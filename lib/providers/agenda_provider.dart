import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/entities/agenda.dart';
import 'package:agenda_front/services/notifications_service.dart';
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

  Agenda? buscar(String id) {
    return agendas.where((element) => element.id!.contains(id)).first;
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
      final json = await AgendaAPI.httpPost('/agendas', data);
      final agenda = Agenda.fromJson(json);
      agendas.add(agenda);
      notifyListeners();
      NotificationsService.showSnackbar('Agregado a agendas');
    } catch (e) {
      NotificationsService.showSnackbarError('No agregado a agendas');
    }
  }

  _actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPut('/agendas/$id', data);
      final agenda = Agenda.fromJson(json);
      // Buscamos el index en lista del ID Agenda
      final index = agendas.indexWhere((element) => element.id!.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      agendas[index] = agenda;
      notifyListeners();
      NotificationsService.showSnackbar('Agenda actualizado');
    } catch (e) {
      NotificationsService.showSnackbarError('Agenda no actualizado');
    }
  }

  eliminar(String id) async {
    try {
      final json = await AgendaAPI.httpDelete('/agendas/$id', {});
      final confirmado = json as bool;
      if (confirmado) {
        agendas.removeWhere((agenda) => agenda.id == id);
        notifyListeners();
        NotificationsService.showSnackbar('1 agenda eliminado');
      }
    } catch (e) {
      NotificationsService.showSnackbarError('Agenda no eliminado');
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
