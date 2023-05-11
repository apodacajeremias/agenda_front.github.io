
import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/persona.dart';
import 'package:flutter/material.dart';

class PersonaProvider extends ChangeNotifier {
  List<Persona> personas = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  getPersonas() async {
    try {
      final response = await AgendaAPI.httpGet('/personas');
      List<Persona> personasResponse =
          List<Persona>.from(response.map((model) => Persona.fromJson(model)));
      personas = [...personasResponse];
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  // Future getPersona(String id) async {
  //   try {
  //     final response = await AgendaAPI.httpGet('personas/$id');
  //     return Persona.fromJson(response);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

// Buscamos la persona seleccionada en la lista, sin reconsultar el servidor C;
  Persona getPersona(String id) {
    try {
      return personas.where((element) => element.id!.contains(id)).first;
    } catch (e) {
      rethrow;
    }
  }

  Future newPersona(Persona persona) async {
    final data = persona.toJson();
    try {
      final json = await AgendaAPI.httpPost('/personas', data);
      final newPersona = Persona.fromJson(json);
      personas.add(newPersona);
      notifyListeners();
    } catch (e) {
      throw 'Error al crear Persona';
    }
  }

  Future updatePersona(String id, Persona persona) async {
    final data = persona.toJson();
    try {
      final json = await AgendaAPI.httpPut('/personas/$id', data);
      personas = personas.map((persona) {
        if (persona.id != id) return persona;
        // persona.nombre = name; ???????
        return persona;
      }).toList();
      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar Persona';
    }
  }

  Future deletePersona(String id) async {
    try {
      final json = await AgendaAPI.httpDelete('/personas/$id', {});

      personas.removeWhere((persona) => persona.id == id);

      notifyListeners();
    } catch (e) {
      throw 'Error al eliminar Persona';
    }
  }

  validateForm() {
    return formKey.currentState!.validate();
  }
}
