import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/entities/transaccion.dart';
import 'package:agenda_front/services/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TransaccionProvider extends ChangeNotifier {
  List<Transaccion> transacciones = [];
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  buscarTodos() async {
    final response = await AgendaAPI.httpGet('/transacciones');
    List<Transaccion> transaccionesResponse = List<Transaccion>.from(
        response.map((model) => Transaccion.fromJson(model)));
    transacciones = [...transaccionesResponse];
    notifyListeners();
  }

  Transaccion? buscar(String id) {
    return transacciones.where((element) => element.id!.contains(id)).first;
  }

  registrar(Map<String, dynamic> data) async {
    // Si data tiene un campo ID y este tiene informacion
    if (data.containsKey('ID') && data['ID'] != null) {
      // Actualiza
      await _actualizar(data['ID'], data);
    } else {
      await _guardar(data);
    }
  }

  _guardar(Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPost('/transacciones', data);
      final transaccion = Transaccion.fromJson(json);
      transacciones.add(transaccion);
      notifyListeners();
      NotificationsService.showSnackbar('Agregado a transacciones');
    } catch (e) {
      NotificationsService.showSnackbarError('No agregado a transacciones');
      rethrow;
    }
  }

  _actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPut('/transacciones/$id', data);
      final transaccion = Transaccion.fromJson(json);
      // Buscamos el index en lista del ID Transaccion
      final index =
          transacciones.indexWhere((element) => element.id!.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      transacciones[index] = transaccion;
      notifyListeners();
      NotificationsService.showSnackbar('Transaccion actualizado');
    } catch (e) {
      NotificationsService.showSnackbarError('Transaccion no actualizado');
      rethrow;
    }
  }

  eliminar(String id) async {
    try {
      final json = await AgendaAPI.httpDelete('/transacciones/$id', {});
      final confirmado = json as bool;
      if (confirmado) {
        transacciones.removeWhere((transaccion) => transaccion.id == id);
        notifyListeners();
        NotificationsService.showSnackbar('1 transaccion eliminado');
      }
    } catch (e) {
      NotificationsService.showSnackbarError('Transaccion no eliminado');
      rethrow;
    }
  }

  saveAndValidate() {
    return formKey.currentState!.saveAndValidate();
  }

  formData() {
    return formKey.currentState!.value;
  }
}
