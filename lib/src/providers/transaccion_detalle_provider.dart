import 'package:agenda_front/extensions.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/entities/transaccion_detalle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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
    if (data.containsKey('id') && data['id'] != null) {
      // Actualiza
      return await _actualizar(idTransaccion, idDetalle!, data);
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
      final transaccion = TransaccionDetalle.fromJson(json);
      // Buscamos el index en lista del ID TransaccionDetalle
      final index =
          detalles.indexWhere((element) => element.id.contains(idDetalle));
      // Se substituye la informacion del index por la informacion actualizada
      detalles[index] = transaccion;
      notifyListeners();
      NotificationService.showSnackbar('Editado');
      return transaccion;
    } catch (e) {
      NotificationService.showSnackbarError('No Editado');
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
        NotificationService.showSnackbar('1 transaccion eliminado');
      }
    } catch (e) {
      NotificationService.showSnackbarError('TransaccionDetalle no eliminado');
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
    // notifyListeners();
  }
}
