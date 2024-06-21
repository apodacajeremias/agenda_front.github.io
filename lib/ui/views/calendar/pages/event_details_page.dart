// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/translate.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

import '../extension.dart';
import 'create_event_page.dart';

class DetailsPage extends StatelessWidget {
  final CalendarEventData event;

  const DetailsPage({super.key, required this.event});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: event.color,
        elevation: 0,
        centerTitle: false,
        title: Text(
          event.title,
          style: TextStyle(
            color: event.color.accentColor,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: context.pop,
          icon: Icon(
            Icons.arrow_back,
            color: event.color.accentColor,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Text(
            "${AppLocalizations.of(context)!.fecha}: ${event.date.dateToStringWithFormat(format: "dd/MM/yyyy")}",
          ),
          SizedBox(
            height: 15.0,
          ),
          if (event.startTime != null && event.endTime != null) ...[
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!.de),
                      Text(
                        event.startTime
                                ?.getTimeInFormat(TimeStampFormat.parse_24) ??
                            "",
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!.a),
                      Text(
                        event.endTime
                                ?.getTimeInFormat(TimeStampFormat.parse_24) ??
                            "",
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
          ],
          if (event.description?.isNotEmpty ?? false) ...[
            Divider(),
            Text(AppLocalizations.of(context)!.observacionesTag),
            SizedBox(
              height: 10.0,
            ),
            Text(event.description!),
          ],
          const SizedBox(height: 50),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    CalendarControllerProvider.of(context)
                        .controller
                        .remove(event);
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(context)!.agenda('cancelar')),
                ),
              ),
              SizedBox(width: 30),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => CreateEventPage(
                          event: event,
                        ),
                      ),
                    );

                    if (result) {
                      Navigator.of(context).pop();
                    }
                  },
                  child:
                      Text(AppLocalizations.of(context)!.agenda('actualizar')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
