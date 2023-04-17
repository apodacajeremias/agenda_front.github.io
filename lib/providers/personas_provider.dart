import 'dart:convert';

import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/persona.dart';
import 'package:flutter/material.dart';

class PersonasProvider extends ChangeNotifier {
  List<Persona> personas = [];

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

  Future newPersona(String name) async {
    final data = {'nombre': name};
    try {
      final json = await AgendaAPI.httpPost('/personas', data);
      final newPersona = Persona.fromJson(json);
      personas.add(newPersona);
      notifyListeners();
    } catch (e) {
      throw 'Error al crear Persona';
    }
  }

  Future updatePersona(String id, String name) async {
    final data = {'nombre': name};
    try {
      final json = await AgendaAPI.httpPut('/personas/$id', data);
      personas = personas.map((persona) {
        if (persona.id != id) return persona;
        persona.nombre = name;
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
}
