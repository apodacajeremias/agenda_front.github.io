import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/entities/transaccion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TransaccionProvider extends ChangeNotifier {
  List<Transaccion> transacciones = [];
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  buscarTodos() async {
    final response = await AgendaAPI.httpGet('/transacciones');
    List<Transaccion> transaccionesResponse =
        List<Transaccion>.from(response.map((model) => Transaccion.fromJson(model)));
    transacciones = [...transaccionesResponse];
    notifyListeners();
  }

// Buscamos la transaccion seleccionada en la lista, sin reconsultar el servidor C;
  Transaccion? buscar(String id) {
    return transacciones.isNotEmpty
        ? transacciones.where((element) => element.id!.contains(id)).first
        : null;
  }

  Future guardar(Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPost('/transacciones', data);
      final transaccionNueva = Transaccion.fromJson(json);
      transacciones.add(transaccionNueva);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPut('/transacciones/$id', data);
      final transaccionModificada = Transaccion.fromJson(json);
      // Buscamos el index en lista del ID Transaccion
      final index = transacciones.indexWhere((element) => element.id!.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      transacciones[index] = transaccionModificada;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future eliminar(String id) async {
    try {
      final json = await AgendaAPI.httpDelete('/transacciones/$id', {});
      final confirmado = json as bool;
      if (confirmado) {
        transacciones.removeWhere((transaccion) => transaccion.id == id);
      } else {
        throw Exception('No se ha eliminado el registro');
      }
      notifyListeners();
      return confirmado;
    } catch (e) {
      rethrow;
    }
  }

  validateForm() {
    return formKey.currentState!.validate();
  }

  saveForm() {
    formKey.currentState!.save();
  }
}
