import 'package:agenda_front/extensions.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/entities/movimiento.dart';
import 'package:agenda_front/src/models/entities/movimiento_detalle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class MovimientoProvider extends ChangeNotifier {
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  List<Movimiento> movimientos = [];

  buscarTodos() async {
    final response = await ServerConnection.httpGet('/movimientos');
    List<Movimiento> movimientosResponse = List<Movimiento>.from(
        response.map((model) => Movimiento.fromJson(model)));
    movimientos = [...movimientosResponse];
    notifyListeners();
  }

  Movimiento? buscar(String id) {
    return movimientos.where((element) => element.id.contains(id)).first;
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
      final movimiento = Movimiento.fromJson(json);
      movimientos.add(movimiento);
      notifyListeners();
      NotificationService.showSnackbar('Agregado a movimientos');
      return movimiento;
    } catch (e) {
      NotificationService.showSnackbarError('No agregado a movimientos');
      rethrow;
    }
  }

  _actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await ServerConnection.httpPut('/movimientos/$id', data);
      final movimiento = Movimiento.fromJson(json);
      // Buscamos el index en lista del ID Movimiento
      final index =
          movimientos.indexWhere((element) => element.id.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      movimientos[index] = movimiento;
      notifyListeners();
      NotificationService.showSnackbar('Movimiento actualizado');
      return movimiento;
    } catch (e) {
      NotificationService.showSnackbarError('Movimiento no actualizado');
      rethrow;
    }
  }

  eliminar(String id) async {
    try {
      final json = await ServerConnection.httpDelete('/movimientos/$id', {});
      final confirmado = json.toString().toBoolean();
      if (confirmado) {
        movimientos.removeWhere((movimiento) => movimiento.id == id);
        notifyListeners();
        NotificationService.showSnackbar('1 movimiento eliminado');
      }
    } catch (e) {
      NotificationService.showSnackbarError('Movimiento no eliminado');
      rethrow;
    }
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
    if (data.containsKey('id') && data['id'] != null) {
      // Actualiza
      return await _actualizar(idMovimiento, idDetalle!, data);
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
