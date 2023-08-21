import 'package:agenda_front/datasources/agenda_datasource.dart';
import 'package:agenda_front/providers/agenda_provider.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final agendas = Provider.of<AgendaProvider>(context).agendas;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SfCalendar(
        view: CalendarView.month,
        allowedViews: const [
          CalendarView.schedule,
          CalendarView.day,
          CalendarView.week,
          CalendarView.timelineMonth
        ],
        dataSource: AgendaDataSource(agendas),
        monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            showAgenda: true),
      ),
    );
  }
}
