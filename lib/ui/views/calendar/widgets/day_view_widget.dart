import 'package:agenda_front/providers.dart';
import 'package:agenda_front/src/models/entities/agenda.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/event_details_page.dart';

class DayViewWidget extends StatefulWidget {
  final GlobalKey<DayViewState>? state;
  final double? width;

  const DayViewWidget({
    super.key,
    this.state,
    this.width,
  });

  @override
  State<DayViewWidget> createState() => _DayViewWidgetState();
}

class _DayViewWidgetState extends State<DayViewWidget> {
  @override
  void initState() {
    Provider.of<AgendaProvider>(context, listen: false)
        .buscarPorRango(DateTime.now(), DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AgendaProvider>(context);

    return DayView(
      key: widget.state,
      width: widget.width,
      startDuration: Duration(hours: 8),
      showHalfHours: true,
      heightPerMinute: 3,
      timeLineBuilder: _timeLineBuilder,
      onPageChange: (date, pageIndex) =>
          Provider.of<AgendaProvider>(context, listen: false)
              .buscarPorRango(date, date),
      onDateTap: (date) {
        // Implement callback when user taps on a cell.
        print(date);
      },
      hourIndicatorSettings: HourIndicatorSettings(
        color: Theme.of(context).dividerColor,
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
      halfHourIndicatorSettings: HourIndicatorSettings(
        color: Theme.of(context).dividerColor,
        lineStyle: LineStyle.dashed,
      ),
      verticalLineOffset: 0,
      timeLineWidth: 65,
      showLiveTimeLineInAllDays: true,
      liveTimeIndicatorSettings: LiveTimeIndicatorSettings(
        color: Colors.redAccent,
        showBullet: false,
        showTime: true,
        showTimeBackgroundView: true,
      ),
    );
  }

  Widget _timeLineBuilder(DateTime date) {
    if (date.minute != 0) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            top: -8,
            right: 8,
            child: Text(
              "${date.hour}:${date.minute}",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.black.withAlpha(50),
                fontStyle: FontStyle.italic,
                fontSize: 12,
              ),
            ),
          ),
        ],
      );
    }

    final hour = ((date.hour - 1) % 12) + 1;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          top: -8,
          right: 8,
          child: Text(
            "$hour ${date.hour ~/ 12 == 0 ? "am" : "pm"}",
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  buildEvents(BuildContext context, AgendaProvider provider) {
    var evnts = provider.events;
    CalendarControllerProvider.of(context).controller.addAll(provider.events);
    evnts.removeWhere((element) => (element.event as Agenda).estado == null);
    CalendarControllerProvider.of(context).controller.removeAll(evnts);
  }
}
