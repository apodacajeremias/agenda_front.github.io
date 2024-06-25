import 'package:agenda_front/providers.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/event_details_page.dart';

class MonthViewWidget extends StatefulWidget {
  final GlobalKey<MonthViewState>? state;
  final double? width;

  const MonthViewWidget({
    super.key,
    this.state,
    this.width,
  });

  @override
  State<MonthViewWidget> createState() => _MonthViewWidgetState();
}

class _MonthViewWidgetState extends State<MonthViewWidget> {
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
    return MonthView(
      key: widget.state,
      width: widget.width,
      hideDaysNotInMonth: false,
      onPageChange: (date, pageIndex) => print("$date, $pageIndex"),
      onCellTap: (events, date) {
        // Implement callback when user taps on a cell.
        print(events);
      },
      onEventTap: (event, date) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => DetailsPage(
              event: event,
            ),
          ),
        );
      },
      onEventLongTap: (event, date) {
        SnackBar snackBar = SnackBar(content: Text("on LongTap"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );
  }
}
