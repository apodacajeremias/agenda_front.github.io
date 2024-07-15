import 'package:agenda_front/enums.dart';
import 'package:agenda_front/extensions.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/dto/horario_disponible.dart';
import 'package:agenda_front/src/models/entities/agenda.dart';
import 'package:agenda_front/src/models/entities/agenda_detalle.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AgendaFormProvider extends ChangeNotifier {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  registrar() async {
    // Se guardan los datos y se valida
    if (formKey.currentState!.saveAndValidate()) {
      // Datos guardados
      var values = formKey.currentState!.value;
      var data = Map.of(values);
      var hd = values['horarioDisponible'];
      data.remove('horarioDisponible');
      data.addAll({
        'inicio': hd.inicio.toIso8601String(),
        'fin': hd.fin.toIso8601String()
      });
      // Obtener datos de -horarioDisponible y asignar dentro de los datos que van al servidor como inicio y fin
      // Si data tiene un campo ID y este tiene informacion
      if (data.containsKey('id') && data['id'] != null) {
        // Actualiza
        return await _actualizar(data['id'], data);
      } else {
        return await _guardar(data);
      }
    }
  }

  _guardar(Map<String, dynamic> data) async {
    try {
      final json = await ServerConnection.httpPost('/agendas', data);
      final agenda = Agenda.fromJson(json);
      notifyListeners();
      NotificationService.showSnackbar('Agregado a agendas');
      return _event(agenda);
    } catch (e) {
      NotificationService.showSnackbarError('No agregado a agendas');
      rethrow;
    }
  }

  _actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await ServerConnection.httpPut('/agendas/$id', data);
      final agenda = Agenda.fromJson(json);
      notifyListeners();
      NotificationService.showSnackbar('Agenda actualizado');
      return _event(agenda);
    } catch (e) {
      NotificationService.showSnackbarError('Agenda no actualizado');
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
      String idColaborador, DateTime fecha, Duracion duracion) async {
    try {
      final json =
          await ServerConnection.httpGet('/agendas/horariosDisponibles', data: {
        'idColaborador': idColaborador,
        'fecha': fecha.dateToStringWithFormat(format: 'yyyy-MM-dd'),
        'duracion': duracion.duracion
      });
      final horariosDisponible = List<HorarioDisponible>.from(
          json.map((model) => HorarioDisponible.fromJson(model)));
      if (horariosDisponible.isEmpty) {
        NotificationService.showSnackbarWarn('No hay horarios disponibles');
      }
      return horariosDisponible;
    } catch (e) {
      NotificationService.showSnackbarError(
          'No se puede encontrar disponibilidad, reintente.');
      rethrow;
    }
  }
}

class AgendaDetalleProvider extends ChangeNotifier {
  Agenda? agenda;
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  List<AgendaDetalle> detalles = [];

  Future<AgendaDetalle> registrar(String idAgenda, Map<String, dynamic> data,
      {String? idDetalle}) async {
    // Si data tiene un campo ID y este tiene informacion
    if (idDetalle != null) {
      // Actualiza
      return await _actualizar(idAgenda, idDetalle, data);
    } else {
      return await _guardar(idAgenda, data);
    }
  }

  Future<AgendaDetalle> _guardar(
      String idAgenda, Map<String, dynamic> data) async {
    try {
      final json =
          await ServerConnection.httpPost('/agendas/$idAgenda/detalles', data);
      final detalle = AgendaDetalle.fromJson(json);
      _index(detalle);
      NotificationService.showSnackbar('Agregado');
      buscar(idAgenda);
      return detalle;
    } catch (e) {
      NotificationService.showSnackbarError('No agregado');
      rethrow;
    }
  }

  Future<AgendaDetalle> _actualizar(
      String idAgenda, String idDetalle, Map<String, dynamic> data) async {
    try {
      final json = await ServerConnection.httpPut(
          '/agendas/$idAgenda/detalles/$idDetalle', data);
      final detalle = AgendaDetalle.fromJson(json);
      _index(detalle);
      NotificationService.showSnackbar('Editado');
      buscar(idAgenda);
      return detalle;
    } catch (e) {
      NotificationService.showSnackbarError('No editado');
      rethrow;
    }
  }

  _index(AgendaDetalle detalle) {
    // Buscamos el index en lista del ID Persona
    final index =
        detalles.indexWhere((element) => element.id.contains(detalle.id));
    if (index == -1) {
      detalles.add(detalle);
    } else {
      // Se substituye la informacion del index por la informacion actualizada
      detalles[index] = detalle;
    }
    notifyListeners();
  }

  Future buscar(String id) async {
    try {
      final json = await ServerConnection.httpGet('/agendas/$id');
      agenda = Agenda.fromJson(json);
      // NotificationService.showSnackbar('Encontrado');
      notifyListeners();
      return agenda;
    } catch (e) {
      NotificationService.showSnackbarError('No encontrado');
      rethrow;
    }
  }

  Future cambiarEstado(String id, Situacion situacion,
      {String? observacion}) async {
    try {
      await ServerConnection.httpPut('/agendas/$id/cambiarEstado',
          {'situacion': situacion, 'observacion': observacion});
      switch (situacion) {
        case Situacion.PRESENTE:
          NotificationService.showSnackbarError('Iniciando...');
          break;
        case Situacion.FINALIZADO:
          NotificationService.showSnackbarError('Finalizado');
          break;
        case Situacion.PENDIENTE:
          throw Exception('No se puede volver a habilitar un horario.');
        default:
          NotificationService.showSnackbarError('Cancelado');
          break;
      }
      buscar(id);
      notifyListeners();
    } catch (e) {
      switch (situacion) {
        case Situacion.PRESENTE:
          NotificationService.showSnackbarError(
              'No se puede iniciar atención, reintente.');
          break;
        case Situacion.FINALIZADO:
          NotificationService.showSnackbarError(
              'No se puede finalizar atención, reintente.');
          break;
        case Situacion.PENDIENTE:
          NotificationService.showSnackbarError(
              'No se puede volver a habilitar un horario.');
          break;
        default:
          NotificationService.showSnackbarError(
              'No se puede cancelar la reserva, reintente.');
          break;
      }

      rethrow;
    }
  }
}

class AgendaIndexProvider extends ChangeNotifier {
  List<CalendarEventData> events = [];

  buscarPorRango(DateTime inicio, DateTime fin) async {
    final response = await ServerConnection.httpGet('/agendas', data: {
      'inicio': inicio.toIso8601String(),
      'fin': fin.toIso8601String()
    });
    List<Agenda> agendasResponse =
        List<Agenda>.from(response.map((model) => Agenda.fromJson(model)));
    List<CalendarEventData> eventResponse = List<CalendarEventData>.from(
        agendasResponse.map((model) => _event(model)));
    // events = [...eventResponse];
    events = eventResponse;
    notifyListeners();
  }
}

_event(Agenda a) {
  final e = CalendarEventData(
      event: a,
      date: a.inicio,
      endTime: a.fin,
      startTime: a.inicio,
      endDate: a.fin,
      color: a.prioridad.color,
      title: a.persona.nombre.firstWord(),
      description: a.observacion);
  return e;
}
