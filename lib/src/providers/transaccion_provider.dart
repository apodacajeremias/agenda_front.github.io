import 'package:agenda_front/extensions.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/entities/transaccion.dart';
import 'package:agenda_front/src/models/entities/transaccion_detalle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TransaccionFormProvider extends ChangeNotifier {
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  Transaccion? transaccion;

  Future buscar(String id) async {
    try {
      final json = await ServerConnection.httpGet('/transacciones/$id');
      transaccion = Transaccion.fromJson(json);
      NotificationService.showSnackbar('Encontrado');
      notifyListeners();
      return transaccion;
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
      final json = await ServerConnection.httpPost('/transacciones', data);
      transaccion = Transaccion.fromJson(json);
      NotificationService.showSnackbar('Agregado a transacciones');
      notifyListeners();
      return transaccion;
    } catch (e) {
      NotificationService.showSnackbarError('No agregado a transacciones');
      rethrow;
    }
  }

  _actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await ServerConnection.httpPut('/transacciones/$id', data);
      transaccion = Transaccion.fromJson(json);
      NotificationService.showSnackbar('Transacción actualizada');
      notifyListeners();
      return transaccion;
    } catch (e) {
      NotificationService.showSnackbarError('Transacción no actualizada');
      rethrow;
    }
  }

  aplicarDescuento(String id, bool aplicar, double descuento) async {
    try {
      final json = await ServerConnection.httpPut(
          '/transacciones/$id/aplicarDescuento',
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
      if (transaccion!.sumatoria <= 0) {
        NotificationService.showSnackbarError(
            'La sumatoria debe ser superior a cero');
        throw Exception('La sumatoria debe ser superior a cero');
      }
      await ServerConnection.httpPut(
          '/transacciones/$id/cambiarEstado', {'estado': estado});
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

  imprimir(String id) async {
    try {
      final impresion =
          await ServerConnection.httpGet('/transacciones/$id/imprimir');
      print(impresion);
      notifyListeners();
    } catch (e) {
      NotificationService.showSnackbarError('Estado no cambiado');
      rethrow;
    }
  }
}

class TransaccionIndexProvider extends ChangeNotifier {
  List<Transaccion> transacciones = [];

  buscarTodos() async {
    final response = await ServerConnection.httpGet('/transacciones');
    List<Transaccion> transaccionesResponse = List<Transaccion>.from(
        response.map((model) => Transaccion.fromJson(model)));
    transacciones = [...transaccionesResponse];
    notifyListeners();
  }
}

class TransaccionDetalleProvider extends ChangeNotifier {
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  List<TransaccionDetalle> detalles = [];

  buscarTodos() async {
    final response = await ServerConnection.httpGet('/transacciones');
    List<TransaccionDetalle> transaccionesResponse =
        List<TransaccionDetalle>.from(
            response.map((model) => TransaccionDetalle.fromJson(model)));
    detalles = [...transaccionesResponse];
    notifyListeners();
  }

  buscarPorTransaccion(String id) async {
    final response =
        await ServerConnection.httpGet('/transacciones/$id/detalles');
    List<TransaccionDetalle> transaccionesResponse =
        List<TransaccionDetalle>.from(
            response.map((model) => TransaccionDetalle.fromJson(model)));
    detalles = [...transaccionesResponse];
    notifyListeners();
  }

  Future<TransaccionDetalle> registrar(
      String idTransaccion, Map<String, dynamic> data,
      {String? idDetalle}) async {
    // Si data tiene un campo ID y este tiene informacion
    if (idDetalle != null) {
      // Actualiza
      return await _actualizar(idTransaccion, idDetalle, data);
    } else {
      return await _guardar(idTransaccion, data);
    }
  }

  Future<TransaccionDetalle> _guardar(
      String idTransaccion, Map<String, dynamic> data) async {
    try {
      final json = await ServerConnection.httpPost(
          '/transacciones/$idTransaccion/detalles', data);
      final detalle = TransaccionDetalle.fromJson(json);
      _index(detalle);
      NotificationService.showSnackbar('Agregado');
      return detalle;
    } catch (e) {
      NotificationService.showSnackbarError('No agregado');
      rethrow;
    }
  }

  Future<TransaccionDetalle> _actualizar(
      String idTransaccion, String idDetalle, Map<String, dynamic> data) async {
    try {
      final json = await ServerConnection.httpPut(
          '/transacciones/$idTransaccion/detalles/$idDetalle', data);
      final detalle = TransaccionDetalle.fromJson(json);
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
      final json = await ServerConnection.httpDelete('/transacciones/$id', {});
      final confirmado = json.toString().toBoolean();
      if (confirmado) {
        detalles.removeWhere((transaccion) => transaccion.id == id);
        notifyListeners();
        NotificationService.showSnackbarWarn('Eliminado');
      }
    } catch (e) {
      NotificationService.showSnackbarError('No eliminado');
      rethrow;
    }
  }

  _index(TransaccionDetalle detalle) {
    // Buscamos el index en lista del ID Persona
    final index =
        detalles.indexWhere((element) => element.id.contains(detalle.id));
    if (index == -1) {
      detalles.add(detalle);
    } else {
      // Se substituye la informacion del index por la informacion actualizada
      detalles[index] = detalle;
    }
    notifyListeners();
  }
}
