import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/entities/beneficio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class BeneficioProvider extends ChangeNotifier {
  List<Beneficio> beneficios = [];
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  buscarTodos() async {
    final response = await AgendaAPI.httpGet('/beneficios');
    List<Beneficio> beneficiosResponse =
        List<Beneficio>.from(response.map((model) => Beneficio.fromJson(model)));
    beneficios = [...beneficiosResponse];
    notifyListeners();
  }

// Buscamos la beneficio seleccionada en la lista, sin reconsultar el servidor C;
  Beneficio? buscar(String id) {
    return beneficios.isNotEmpty
        ? beneficios.where((element) => element.id!.contains(id)).first
        : null;
  }

  Future guardar(Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPost('/beneficios', data);
      final beneficioNueva = Beneficio.fromJson(json);
      beneficios.add(beneficioNueva);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPut('/beneficios/$id', data);
      final beneficioModificada = Beneficio.fromJson(json);
      // Buscamos el index en lista del ID Beneficio
      final index = beneficios.indexWhere((element) => element.id!.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      beneficios[index] = beneficioModificada;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future eliminar(String id) async {
    try {
      final json = await AgendaAPI.httpDelete('/beneficios/$id', {});
      final confirmado = json as bool;
      if (confirmado) {
        beneficios.removeWhere((beneficio) => beneficio.id == id);
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
