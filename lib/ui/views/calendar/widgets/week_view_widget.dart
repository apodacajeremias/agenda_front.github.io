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
    final hoy = DateTime.now();
    final inicioSemana = getDate(hoy.subtract(Duration(days: hoy.weekday - 1)));
    final finalSemana =
        getDate(hoy.add(Duration(days: DateTime.daysPerWeek - hoy.weekday)));
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
      onPageChange: (date, pageIndex) => print("$date, $pageIndex"),
      onDateTap: (date) {
        // Implement callback when user taps on a cell.
        print(date);
      },
      liveTimeIndicatorSettings: LiveTimeIndicatorSettings(
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
        SnackBar snackBar = SnackBar(content: Text("on LongTap"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );
  }
}
