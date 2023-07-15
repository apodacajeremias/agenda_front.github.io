import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/entities/persona.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class PersonaProvider extends ChangeNotifier {
  List<Persona> personas = [];
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  buscarTodos() async {
    final response = await AgendaAPI.httpGet('/personas');
    List<Persona> personasResponse =
        List<Persona>.from(response.map((model) => Persona.fromJson(model)));
    personas = [...personasResponse];
    notifyListeners();
  }

// Buscamos la persona seleccionada en la lista, sin reconsultar el servidor C;
  Future buscar(String id) async {
    return personas.isNotEmpty
        ? personas.where((element) => element.id!.contains(id)).first
        : Persona.fromJson(await _encontrar(id) as Map<String, dynamic>);
  }

  Future _encontrar(String id) async {
    try {
      final json = await AgendaAPI.httpGet('/personas/$id');
      final personaEncontrada = Persona.fromJson(json);
      // Verifificar si el ID ya existe en la lista
      if (personas.where((element) => element.id!.contains(id)).isNotEmpty) {
        final index =
            personas.indexWhere((element) => element.id!.contains(id));
        // Si existe el ID, substituye el contenido
        personas[index] = personaEncontrada;
      } else {
        // Si no existe el ID, agrega al final de la lista
        personas.add(personaEncontrada);
      }
      notifyListeners();
      return personaEncontrada;
    } catch (e) {
      rethrow;
    }
  }

  Future guardar(Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPost('/personas', data);
      final personaNueva = Persona.fromJson(json);
      personas.add(personaNueva);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPut('/personas/$id', data);
      final personaModificada = Persona.fromJson(json);
      // Buscamos el index en lista del ID Persona
      final index = personas.indexWhere((element) => element.id!.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      personas[index] = personaModificada;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future eliminar(String id) async {
    try {
      final json = await AgendaAPI.httpDelete('/personas/$id', {});
      final confirmado = json as bool;
      if (confirmado) {
        personas.removeWhere((persona) => persona.id == id);
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
