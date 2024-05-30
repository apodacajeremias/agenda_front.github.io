import 'package:agenda_front/extensions.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/entities/agenda.dart';
import 'package:agenda_front/src/models/entities/persona.dart';
import 'package:agenda_front/src/models/entities/transaccion.dart';
import 'package:flutter/material.dart';

// TODO: separar provider de form y de index
class PersonaProvider extends ChangeNotifier {
  List<Persona> personas = [];

  buscarTodos() async {
    final response = await ServerConnection.httpGet('/personas');
    List<Persona> personasResponse =
        List<Persona>.from(response.map((model) => Persona.fromJson(model)));
    personas = [...personasResponse];
    notifyListeners();
  }

  Persona? buscar(String id) {
    if (personas.isEmpty) return null;

    return personas.where((element) => element.id!.contains(id)).first;
  }

  registrar(Map<String, dynamic> data) async {
    // Si data tiene un campo ID y este tiene informacion
    if (data.containsKey('id') && data['id'] != null) {
      // Actualiza
      return await _actualizar(data['id'], data);
    } else {
      return await _guardar(data);
    }
  }

  _guardar(Map<String, dynamic> data) async {
    try {
      final json = await ServerConnection.httpPost('/personas', data);
      final persona = Persona.fromJson(json);
      personas.add(persona);
      notifyListeners();
      NotificationService.showSnackbar('Agregado a personas');
      return persona;
    } catch (e) {
      NotificationService.showSnackbarError('No agregado a personas');
      rethrow;
    }
  }

  _actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await ServerConnection.httpPut('/personas/$id', data);
      final persona = Persona.fromJson(json);
      // Buscamos el index en lista del ID Persona
      final index = personas.indexWhere((element) => element.id!.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      personas[index] = persona;
      notifyListeners();
      NotificationService.showSnackbar('Persona actualizada');
      return persona;
    } catch (e) {
      NotificationService.showSnackbarError('Persona no actualizada');
      rethrow;
    }
  }

  eliminar(String id) async {
    try {
      final json = await ServerConnection.httpDelete('/personas/$id', {});
      final confirmado = json as bool;
      if (confirmado) {
        personas.removeWhere((persona) => persona.id == id);
        notifyListeners();
        NotificationService.showSnackbar('1 persona eliminado');
      }
    } catch (e) {
      NotificationService.showSnackbarError('Persona no eliminado');
      rethrow;
    }
  }

  Future<List<Transaccion>> transacciones(String id) async {
    try {
      final json =
          await ServerConnection.httpGet('/personas/$id/transacciones');
      List<Transaccion> response =
          List.from(json.map((model) => Transaccion.fromJson(model)));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Agenda>> agendas(String id) async {
    try {
      final json = await ServerConnection.httpGet('/personas/$id/agendas');
      List<Agenda> response =
          List.from(json.map((model) => Agenda.fromJson(model)));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  existeDocumento(String documentoIdentidad) async {
    try {
      final json = await ServerConnection.httpGet(
          '/personas/existeDocumento/$documentoIdentidad');
      return json.toString().toBoolean();
    } catch (e) {
      rethrow;
    }
  }
}
