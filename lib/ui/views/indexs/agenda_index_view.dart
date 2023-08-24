import 'dart:math';

import 'package:agenda_front/datasources/agenda_datasource.dart';
import 'package:agenda_front/providers/agenda_provider.dart';
import 'package:agenda_front/providers/colaborador_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AgendaIndexView extends StatefulWidget {
  const AgendaIndexView({super.key});

  @override
  State<AgendaIndexView> createState() => _AgendaIndexViewState();
}

class _AgendaIndexViewState extends State<AgendaIndexView> {
  @override
  void initState() {
    Provider.of<AgendaProvider>(context, listen: false).buscarTodos();
    Provider.of<ColaboradorProvider>(context, listen: false).buscarTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final agendas = Provider.of<AgendaProvider>(context).agendas;
    final colaboradores =
        Provider.of<ColaboradorProvider>(context).colaboradores;

    List<CalendarResource> resourceColl = <CalendarResource>[];
    resourceColl.addAll(colaboradores.map((c) => CalendarResource(
          displayName: c.nombre!,
          id: c.id!,
          color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
              .withOpacity(1.0),
        )));

    List<Appointment> source = <Appointment>[];
    source.addAll(agendas.map((e) => Appointment(
          startTime: e.inicio,
          endTime: e.fin,
          color: e.prioridad!.color,
          isAllDay: e.diaCompleto!,
          id: e.id,
          resourceIds: [e.colaborador!.id!],
          subject: '${e.nombre!} ${e.persona!.nombre!}',
          notes: e.nombre!,
        )));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SfCalendar(
        view: CalendarView.timelineMonth,
        monthViewSettings: const MonthViewSettings(showAgenda: true),
        allowedViews: const [
          CalendarView.schedule,
          CalendarView.timelineDay,
          CalendarView.timelineWeek,
          CalendarView.timelineWorkWeek,
          CalendarView.timelineMonth
        ],
        dataSource: AgendaDataSource(source, resourceColl),
        resourceViewSettings: const ResourceViewSettings(showAvatar: false),
      ),
    );
  }
}
