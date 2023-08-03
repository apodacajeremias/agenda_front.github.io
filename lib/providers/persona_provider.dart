import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/entities/persona.dart';
import 'package:agenda_front/services/notifications_service.dart';
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

  Future<Persona> buscar(String id) async {
    final json = await AgendaAPI.httpGet('/personas/$id');
    return Persona.fromJson(json);
  }

  registrar(Map<String, dynamic> data) async {
    // Si data tiene un campo ID y este tiene informacion
    if (data.containsKey('id') && data['id'] != null) {
      // Actualiza
      await _actualizar(data['id'], data);
    } else {
      await _guardar(data);
    }
  }

  _guardar(Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPost('/personas', data);
      final personaNueva = Persona.fromJson(json);
      personas.add(personaNueva);
      notifyListeners();
      NotificationsService.showSnackbar('Agregado a personas');
    } catch (e) {
      rethrow;
    }
  }

  _actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPut('/personas/$id', data);
      final personaModificada = Persona.fromJson(json);
      // Buscamos el index en lista del ID Persona
      final index = personas.indexWhere((element) => element.id!.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      personas[index] = personaModificada;
      notifyListeners();
      NotificationsService.showSnackbar('Persona actualizado');
    } catch (e) {
      rethrow;
    }
  }

  eliminar(String id) async {
    try {
      final json = await AgendaAPI.httpDelete('/personas/$id', {});
      final confirmado = json as bool;
      if (confirmado) {
        personas.removeWhere((persona) => persona.id == id);
        notifyListeners();
        NotificationsService.showSnackbar('1 persona eliminado');
      }
    } catch (e) {
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
