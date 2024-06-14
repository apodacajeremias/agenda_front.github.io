import 'package:agenda_front/extensions.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/entities/movimiento.dart';
import 'package:agenda_front/src/models/entities/movimiento_detalle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class MovimientoFormProvider extends ChangeNotifier {
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  Movimiento? movimiento;

  Future buscar(String id) async {
    try {
      final json = await ServerConnection.httpGet('/movimientos/$id');
      movimiento = Movimiento.fromJson(json);
      NotificationService.showSnackbar('Encontrado');
      notifyListeners();
      return movimiento;
    } catch (e) {
      NotificationService.showSnackbarError('No encontrado');
      rethrow;
    }
  }

  registrar(Map<String, dynamic> data) async {
    // Si data tiene un campo ID y este tiene informacion
    if (data.containsKey('id') && data['id'] != null) {
      // Actualiza
      return await _actualizar(data['id'], data);
    } else {
      return await _guardar(data);
    }
  }

  _guardar(Map<String, dynamic> data) async {
    try {
      final json = await ServerConnection.httpPost('/movimientos', data);
      movimiento = Movimiento.fromJson(json);
      NotificationService.showSnackbar('Agregado a movimientos');
      notifyListeners();
      return movimiento;
    } catch (e) {
      NotificationService.showSnackbarError('No agregado a movimientos');
      rethrow;
    }
  }

  _actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await ServerConnection.httpPut('/movimientos/$id', data);
      movimiento = Movimiento.fromJson(json);
      NotificationService.showSnackbar('Transacción actualizada');
      notifyListeners();
      return movimiento;
    } catch (e) {
      NotificationService.showSnackbarError('Transacción no actualizada');
      rethrow;
    }
  }

  aplicarDescuento(String id, bool aplicar, double descuento) async {
    try {
      final json = await ServerConnection.httpPut(
          '/movimientos/$id/aplicarDescuento',
          {'aplicar': aplicar, 'descuento': descuento});
      if (json['aplicar'].toString().toBoolean()) {
        NotificationService.showSnackbarWarn('Descuento aplicado');
      } else {
        NotificationService.showSnackbarWarn('Descuento quitado');
      }
      formKey.currentState!.fields['-sumatoria']!
          .didChange((json['sumatoria']).toString());
      formKey.currentState!.fields['descuento']!
          .didChange((json['descuento']).toString());
      formKey.currentState!.fields['-total']!
          .didChange((json['total']).toString());
      notifyListeners();
    } catch (e) {
      if (aplicar) {
        NotificationService.showSnackbarError('Descuento no aplicado');
      } else {
        NotificationService.showSnackbarError('Descuento no quitado');
      }
      rethrow;
    }
  }

  cambiarEstado(String id, bool? estado) async {
    try {
      if (movimiento!.total <= 0) {
        NotificationService.showSnackbarError(
            'El total debe ser superior a cero');
        throw Exception('La sumatoria debe ser superior a cero');
      }
      await ServerConnection.httpPut(
          '/movimientos/$id/cambiarEstado', {'estado': estado});
      if (estado == null) {
        NotificationService.showSnackbarWarn('Estado PENDIENTE');
      } else if (estado) {
        NotificationService.showSnackbarWarn('Estado APROBADO');
      } else {
        NotificationService.showSnackbarWarn('Estado RECHAZADO');
      }
      notifyListeners();
    } catch (e) {
      NotificationService.showSnackbarError('Estado no cambiado');
      rethrow;
    }
  }
}

class MovimientoIndexProvider extends ChangeNotifier {
  List<Movimiento> movimientos = [];

  buscarTodos() async {
    final response = await ServerConnection.httpGet('/movimientos');
    List<Movimiento> movimientosResponse = List<Movimiento>.from(
        response.map((model) => Movimiento.fromJson(model)));
    movimientos = [...movimientosResponse];
    notifyListeners();
  }
}

class MovimientoDetalleProvider extends ChangeNotifier {
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  List<MovimientoDetalle> detalles = [];

  buscarTodos() async {
    final response = await ServerConnection.httpGet('/movimientos');
    List<MovimientoDetalle> movimientosResponse = List<MovimientoDetalle>.from(
        response.map((model) => MovimientoDetalle.fromJson(model)));
    detalles = [...movimientosResponse];
    notifyListeners();
  }

  buscarPorMovimiento(String id) async {
    final response =
        await ServerConnection.httpGet('/movimientos/$id/detalles');
    List<MovimientoDetalle> movimientosResponse = List<MovimientoDetalle>.from(
        response.map((model) => MovimientoDetalle.fromJson(model)));
    detalles = [...movimientosResponse];
    notifyListeners();
  }

  Future<MovimientoDetalle> registrar(
      String idMovimiento, Map<String, dynamic> data,
      {String? idDetalle}) async {
    // Si data tiene un campo ID y este tiene informacion
    if (idDetalle != null) {
      // Actualiza
      return await _actualizar(idMovimiento, idDetalle, data);
    } else {
      return await _guardar(idMovimiento, data);
    }
  }

  Future<MovimientoDetalle> _guardar(
      String idMovimiento, Map<String, dynamic> data) async {
    try {
      final json = await ServerConnection.httpPost(
          '/movimientos/$idMovimiento/detalles', data);
      final detalle = MovimientoDetalle.fromJson(json);
      _index(detalle);
      NotificationService.showSnackbar('Agregado');
      return detalle;
    } catch (e) {
      NotificationService.showSnackbarError('No agregado');
      rethrow;
    }
  }

  Future<MovimientoDetalle> _actualizar(
      String idMovimiento, String idDetalle, Map<String, dynamic> data) async {
    try {
      final json = await ServerConnection.httpPut(
          '/movimientos/$idMovimiento/detalles/$idDetalle', data);
      final detalle = MovimientoDetalle.fromJson(json);
      _index(detalle);
      NotificationService.showSnackbar('Editado');
      return detalle;
    } catch (e) {
      NotificationService.showSnackbarError('No editado');
      rethrow;
    }
  }

  eliminar(String id) async {
    try {
      final json = await ServerConnection.httpDelete('/movimientos/$id', {});
      final confirmado = json.toString().toBoolean();
      if (confirmado) {
        detalles.removeWhere((movimiento) => movimiento.id == id);
        notifyListeners();
        NotificationService.showSnackbarWarn('Eliminado');
      }
    } catch (e) {
      NotificationService.showSnackbarError('No eliminado');
      rethrow;
    }
  }

  _index(MovimientoDetalle detalle) {
    // Buscamos el index en lista del ID Persona
    final index =
        detalles.indexWhere((element) => element.id.contains(detalle.id));
    if (index == -1) {
      detalles.add(detalle);
    } else {
      // Se substituye la informacion del index por la informacion actualizada
      detalles[index] = detalle;
    }
    // notifyListeners();
  }
}
