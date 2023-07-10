import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/entities/colaborador.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ColaboradorProvider extends ChangeNotifier {
  List<Colaborador> colaboradors = [];
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  buscarTodos() async {
    final response = await AgendaAPI.httpGet('/colaboradores');
    List<Colaborador> colaboradorsResponse =
        List<Colaborador>.from(response.map((model) => Colaborador.fromJson(model)));
    colaboradors = [...colaboradorsResponse];
    notifyListeners();
  }

// Buscamos la colaborador seleccionada en la lista, sin reconsultar el servidor C;
  Colaborador? buscar(String id) {
    return colaboradors.isNotEmpty
        ? colaboradors.where((element) => element.id!.contains(id)).first
        : null;
  }

  Future guardar(Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPost('/colaboradors', data);
      final colaboradorNueva = Colaborador.fromJson(json);
      colaboradors.add(colaboradorNueva);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPut('/colaboradors/$id', data);
      final colaboradorModificada = Colaborador.fromJson(json);
      // Buscamos el index en lista del ID Colaborador
      final index = colaboradors.indexWhere((element) => element.id!.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      colaboradors[index] = colaboradorModificada;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future eliminar(String id) async {
    try {
      final json = await AgendaAPI.httpDelete('/colaboradors/$id', {});
      final confirmado = json as bool;
      if (confirmado) {
        colaboradors.removeWhere((colaborador) => colaborador.id == id);
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
