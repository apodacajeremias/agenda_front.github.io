// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/models/entities/agenda.dart';
import 'package:agenda_front/models/enums/prioridad.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AgendaDataSource extends CalendarDataSource {
  final List<Agenda> _agendas;
  AgendaDataSource(this._agendas) {
    super.appointments = _agendas;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].inicio;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].fin;
  }

  @override
  String getSubject(int index) {
    return appointments![index].nombre;
  }

  @override
  Color getColor(int index) {
    return _agendas[index].prioridad!.color;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].diaCompleto;
  }
}
