import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/entities/grupo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class GrupoProvider extends ChangeNotifier {
  List<Grupo> grupos = [];
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  buscarTodos() async {
    final response = await AgendaAPI.httpGet('/grupos');
    List<Grupo> gruposResponse =
        List<Grupo>.from(response.map((model) => Grupo.fromJson(model)));
    grupos = [...gruposResponse];
    notifyListeners();
  }

// Buscamos la grupo seleccionada en la lista, sin reconsultar el servidor C;
  Grupo? buscar(String id) {
    return grupos.isNotEmpty
        ? grupos.where((element) => element.id!.contains(id)).first
        : null;
  }

  Future guardar(Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPost('/grupos', data);
      final grupoNueva = Grupo.fromJson(json);
      grupos.add(grupoNueva);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPut('/grupos/$id', data);
      final grupoModificada = Grupo.fromJson(json);
      // Buscamos el index en lista del ID Grupo
      final index = grupos.indexWhere((element) => element.id!.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      grupos[index] = grupoModificada;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future eliminar(String id) async {
    try {
      final json = await AgendaAPI.httpDelete('/grupos/$id', {});
      final confirmado = json as bool;
      if (confirmado) {
        grupos.removeWhere((grupo) => grupo.id == id);
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
