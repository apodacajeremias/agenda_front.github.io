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

  Persona? buscar(String id) {
    return personas.where((element) => element.id!.contains(id)).first;
  }

  registrar(Map<String, dynamic> data) async {
    // Si data tiene un campo ID y este tiene informacion
    if (data.containsKey('ID') && data['ID'] != null) {
      // Actualiza
      await _actualizar(data['ID'], data);
    } else {
      await _guardar(data);
    }
  }

  _guardar(Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPost('/personas', data);
      final persona = Persona.fromJson(json);
      personas.add(persona);
      notifyListeners();
      NotificationsService.showSnackbar('Agregado a personas');
    } catch (e) {
      NotificationsService.showSnackbarError('No agregado a personas');
      rethrow;
    }
  }

  _actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPut('/personas/$id', data);
      final persona = Persona.fromJson(json);
      // Buscamos el index en lista del ID Persona
      final index = personas.indexWhere((element) => element.id!.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      personas[index] = persona;
      notifyListeners();
      NotificationsService.showSnackbar('Persona actualizada');
    } catch (e) {
      NotificationsService.showSnackbarError('Persona no actualizada');
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
      NotificationsService.showSnackbarError('Persona no eliminado');
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
