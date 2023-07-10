import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/entities/promocion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class PromocionProvider extends ChangeNotifier {
  List<Promocion> promociones = [];
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  buscarTodos() async {
    final response = await AgendaAPI.httpGet('/promociones');
    List<Promocion> promocionesResponse = List<Promocion>.from(
        response.map((model) => Promocion.fromJson(model)));
    promociones = [...promocionesResponse];
    notifyListeners();
  }

// Buscamos la promocion seleccionada en la lista, sin reconsultar el servidor C;
  Promocion? buscar(String id) {
    return promociones.isNotEmpty
        ? promociones.where((element) => element.id!.contains(id)).first
        : null;
  }

  Future guardar(Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPost('/promociones', data);
      final promocionNueva = Promocion.fromJson(json);
      promociones.add(promocionNueva);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPut('/promociones/$id', data);
      final promocionModificada = Promocion.fromJson(json);
      // Buscamos el index en lista del ID Promocion
      final index =
          promociones.indexWhere((element) => element.id!.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      promociones[index] = promocionModificada;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future eliminar(String id) async {
    try {
      final json = await AgendaAPI.httpDelete('/promociones/$id', {});
      final confirmado = json as bool;
      if (confirmado) {
        promociones.removeWhere((promocion) => promocion.id == id);
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
