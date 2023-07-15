import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/entities/agenda.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AgendaProvider extends ChangeNotifier {
  List<Agenda> agendas = [];
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  buscarTodos() async {
    final response = await AgendaAPI.httpGet('/agendas');
    List<Agenda> agendasResponse =
        List<Agenda>.from(response.map((model) => Agenda.fromJson(model)));
    agendas = [...agendasResponse];
    notifyListeners();
  }

// Buscamos la agenda seleccionada en la lista, sin reconsultar el servidor C;
  Future buscar(String id) async {
    return agendas.isNotEmpty
        ? agendas.where((element) => element.id!.contains(id)).first
        : Agenda.fromJson(await _encontrar(id) as Map<String, dynamic>);
  }

  Future _encontrar(String id) async {
    try {
      final json = await AgendaAPI.httpGet('/agendas/$id');
      final agendaEncontrada = Agenda.fromJson(json);
      // Verifificar si el ID ya existe en la lista
      if (agendas.where((element) => element.id!.contains(id)).isNotEmpty) {
        final index =
            agendas.indexWhere((element) => element.id!.contains(id));
        // Si existe el ID, substituye el contenido
        agendas[index] = agendaEncontrada;
      } else {
        // Si no existe el ID, agrega al final de la lista
        agendas.add(agendaEncontrada);
      }
      notifyListeners();
      return agendaEncontrada;
    } catch (e) {
      rethrow;
    }
  }

  Future guardar(Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPost('/agendas', data);
      final agendaNueva = Agenda.fromJson(json);
      agendas.add(agendaNueva);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPut('/agendas/$id', data);
      final agendaModificada = Agenda.fromJson(json);
      // Buscamos el index en lista del ID Agenda
      final index = agendas.indexWhere((element) => element.id!.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      agendas[index] = agendaModificada;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future eliminar(String id) async {
    try {
      final json = await AgendaAPI.httpDelete('/agendas/$id', {});
      final confirmado = json as bool;
      if (confirmado) {
        agendas.removeWhere((agenda) => agenda.id == id);
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
