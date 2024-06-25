import 'package:agenda_front/providers.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/event_details_page.dart';

class WeekViewWidget extends StatefulWidget {
  final GlobalKey<WeekViewState>? state;
  final double? width;

  const WeekViewWidget({super.key, this.state, this.width});

  @override
  State<WeekViewWidget> createState() => _WeekViewWidgetState();
}

class _WeekViewWidgetState extends State<WeekViewWidget> {
  @override
  void initState() {
    final fecha = DateTime.now();
    final inicioSemana =
        getDate(fecha.subtract(Duration(days: fecha.weekday - 1)));
    final finalSemana = getDate(
        fecha.add(Duration(days: DateTime.daysPerWeek - fecha.weekday)));
    Provider.of<AgendaProvider>(context, listen: false)
        .buscarPorRango(inicioSemana, finalSemana);
    super.initState();
  }

  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AgendaProvider>(context);
    CalendarControllerProvider.of(context)
        .controller
        .removeWhere((element) => element.event != null);
    CalendarControllerProvider.of(context).controller.addAll(provider.events);
    return WeekView(
      key: widget.state,
      width: widget.width,
      showLiveTimeLineInAllDays: true,
      timeLineWidth: 65,
      onPageChange: (date, pageIndex) {
        final inicioSemana =
            getDate(date.subtract(Duration(days: date.weekday - 1)));
        final finalSemana = getDate(
            date.add(Duration(days: DateTime.daysPerWeek - date.weekday)));
        Provider.of<AgendaProvider>(context, listen: false)
            .buscarPorRango(inicioSemana, finalSemana);
      },
      onDateTap: (date) {
        // Implement callback when user taps on a cell.
        print(date);
      },
      liveTimeIndicatorSettings: const LiveTimeIndicatorSettings(
        color: Colors.redAccent,
        showTime: true,
      ),
      onEventTap: (events, date) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => DetailsPage(
              event: events.first,
            ),
          ),
        );
      },
      onEventLongTap: (events, date) {
        SnackBar snackBar = const SnackBar(content: Text("on LongTap"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );
  }
}
