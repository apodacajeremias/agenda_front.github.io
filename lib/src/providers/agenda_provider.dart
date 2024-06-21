import 'package:agenda_front/extensions.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/dto/horario_disponible.dart';
import 'package:agenda_front/src/models/entities/agenda.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AgendaProvider extends ChangeNotifier {
  List<Agenda> agendas = [];
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  buscarTodos() async {
    final response = await ServerConnection.httpGet('/agendas');
    List<Agenda> agendasResponse =
        List<Agenda>.from(response.map((model) => Agenda.fromJson(model)));
    agendas = [...agendasResponse];
    notifyListeners();
  }

  Agenda? buscar(String id) {
    return agendas.where((element) => element.id.contains(id)).first;
  }

  registrar() async {
    // Se guardan los datos y se valida
    if (formKey.currentState!.saveAndValidate()) {
      // Datos guardados
      var data = formKey.currentState!.value;
      // Obtener datos de -horarioDisponible y asignar dentro de los datos que van al servidor como inicio y fin
      // Si data tiene un campo ID y este tiene informacion
      if (data.containsKey('id') && data['id'] != null) {
        // Actualiza
        await _actualizar(data['id'], data);
      } else {
        await _guardar(data);
      }
    }
  }

  _guardar(Map<String, dynamic> data) async {
    try {
      final json = await ServerConnection.httpPost('/agendas', data);
      final agenda = Agenda.fromJson(json);
      agendas.add(agenda);
      notifyListeners();
      NotificationService.showSnackbar('Agregado a agendas');
    } catch (e) {
      NotificationService.showSnackbarError('No agregado a agendas');
      rethrow;
    }
  }

  _actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await ServerConnection.httpPut('/agendas/$id', data);
      final agenda = Agenda.fromJson(json);
      // Buscamos el index en lista del ID Agenda
      final index = agendas.indexWhere((element) => element.id.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      agendas[index] = agenda;
      notifyListeners();
      NotificationService.showSnackbar('Agenda actualizado');
    } catch (e) {
      NotificationService.showSnackbarError('Agenda no actualizado');
      rethrow;
    }
  }

  eliminar(String id) async {
    try {
      final json = await ServerConnection.httpDelete('/agendas/$id', {});
      final confirmado = json.toString().toBoolean();
      if (confirmado) {
        agendas.removeWhere((agenda) => agenda.id == id);
        notifyListeners();
        NotificationService.showSnackbar('1 agenda eliminado');
      }
    } catch (e) {
      NotificationService.showSnackbarError('Agenda no eliminado');
      rethrow;
    }
  }

  horarioDisponible(String idColaborador, DateTime inicio, DateTime fin) async {
    try {
      final json = await ServerConnection.httpGet('/agendas/horarioDisponible',
          data: {'idColaborador': idColaborador, 'inicio': inicio, 'fin': fin});
      return json.toString().toBoolean();
    } catch (e) {
      rethrow;
    }
  }

  Future horariosDisponibles(
      String idColaborador, DateTime fecha, int duracion) async {
    try {
      final json =
          await ServerConnection.httpGet('/agendas/horariosDisponibles', data: {
        'idColaborador': idColaborador,
        'fecha': fecha.dateToStringWithFormat(format: 'yyyy-MM-dd'),
        'duracion': duracion
      });
      return List<HorarioDisponible>.from(
          json.map((model) => HorarioDisponible.fromJson(model)));
    } catch (e) {
      rethrow;
    }
  }
}
