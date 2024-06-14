import 'package:agenda_front/enums.dart';
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

  Future buscar(String id) async {
    try {
      final json = await ServerConnection.httpGet('/personas/$id');
      final persona = Persona.fromJson(json);
      _index(persona);
      NotificationService.showSnackbar('Registro encontrado.');
      return persona;
    } catch (e) {
      NotificationService.showSnackbarError('Registro no encontrado.');
      rethrow;
    }
  }

  Future<Persona> registrar(Map<String, dynamic> data) async {
    // Si data tiene un campo ID y este tiene informacion
    if (data.containsKey('id') && data['id'] != null) {
      // Actualiza
      return await _actualizar(data['id'], data);
    } else {
      return await _guardar(data);
    }
  }

  Future<Persona> _guardar(Map<String, dynamic> data) async {
    try {
      final json = await ServerConnection.httpPost('/personas', data);
      final persona = Persona.fromJson(json);
      _index(persona);
      NotificationService.showSnackbar('Agregado a personas');
      return persona;
    } catch (e) {
      NotificationService.showSnackbarError('No agregado a personas');
      rethrow;
    }
  }

  Future<Persona> _actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await ServerConnection.httpPut('/personas/$id', data);
      final persona = Persona.fromJson(json);
      _index(persona);
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

  deudaPendiente(String id,
      {TipoTransaccion tipo = TipoTransaccion.VENTA}) async {
    try {
      final json = await ServerConnection.httpGet(
          '/personas/$id/deudaPendiente',
          data: {'tipo': tipo});
      return json;
    } catch (e) {
      rethrow;
    }
  }

  _index(Persona persona) {
    // Buscamos el index en lista del ID Persona
    final index =
        personas.indexWhere((element) => element.id.contains(persona.id));
    if (index == -1) {
      personas.add(persona);
    } else {
      // Se substituye la informacion del index por la informacion actualizada
      personas[index] = persona;
    }
    // notifyListeners();
  }
}
