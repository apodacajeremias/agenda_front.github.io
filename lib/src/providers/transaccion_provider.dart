import 'package:agenda_front/extensions.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/entities/transaccion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TransaccionProvider extends ChangeNotifier {
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  List<Transaccion> transacciones = [];

  buscarTodos() async {
    final response = await ServerConnection.httpGet('/transacciones');
    List<Transaccion> transaccionesResponse = List<Transaccion>.from(
        response.map((model) => Transaccion.fromJson(model)));
    transacciones = [...transaccionesResponse];
    notifyListeners();
  }

  Transaccion? buscar(String id) {
    return transacciones.where((element) => element.id.contains(id)).first;
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
      final transaccion = Transaccion.fromJson(json);
      transacciones.add(transaccion);
      notifyListeners();
      NotificationService.showSnackbar('Agregado a transacciones');
      return transaccion;
    } catch (e) {
      NotificationService.showSnackbarError('No agregado a transacciones');
      rethrow;
    }
  }

  _actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await ServerConnection.httpPut('/transacciones/$id', data);
      final transaccion = Transaccion.fromJson(json);
      // Buscamos el index en lista del ID Transaccion
      final index =
          transacciones.indexWhere((element) => element.id.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      transacciones[index] = transaccion;
      notifyListeners();
      NotificationService.showSnackbar('Transaccion actualizado');
      return transaccion;
    } catch (e) {
      NotificationService.showSnackbarError('Transaccion no actualizado');
      rethrow;
    }
  }

  eliminar(String id) async {
    try {
      final json = await ServerConnection.httpDelete('/transacciones/$id', {});
      final confirmado = json.toString().toBoolean();
      if (confirmado) {
        transacciones.removeWhere((transaccion) => transaccion.id == id);
        notifyListeners();
        NotificationService.showSnackbar('1 transaccion eliminado');
      }
    } catch (e) {
      NotificationService.showSnackbarError('Transaccion no eliminado');
      rethrow;
    }
  }
}
