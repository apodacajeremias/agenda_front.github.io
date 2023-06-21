import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/persona.dart';
import 'package:agenda_front/services/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class PersonaProvider extends ChangeNotifier {
  List<Persona> personas = [];
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

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
      final personaNueva = Persona.fromJson(json);
      personas.add(personaNueva);
      notifyListeners();
    } catch (e) {
      throw 'Error al crear Persona';
    }
  }

  Future updatePersona(String id, Persona persona) async {
    final data = persona.toJson();
    try {
      final json = await AgendaAPI.httpPut('/personas/$id', data);
      final personaModificada = Persona.fromJson(json);
      // Buscamos el index en lista del ID Persona
      final index = personas.indexWhere((element) => element.id!.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      personas[index] = personaModificada;
      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar Persona';
    }
  }

  Future deletePersona(String id) async {
    try {
      final json = await AgendaAPI.httpDelete('/personas/$id', {});
      final confirmado = json as bool;
      if (confirmado) {
        personas.removeWhere((persona) => persona.id == id);
      } else {
        NotificationsService.showSnackbarError(
            'No se ha podido eliminar registro, intente nuevamente');
      }
      notifyListeners();
    } catch (e) {
      throw 'Error al eliminar Persona';
    }
  }

  validateForm() {
    return formKey.currentState!.validate();
  }
}
