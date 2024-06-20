import 'package:agenda_front/translate.dart';
import 'package:flutter/material.dart';

import '../../extension.dart';
import '../day_view_page.dart';
import '../month_view_page.dart';
import '../week_view_page.dart';

class MobileHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.agendar),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => context.pushRoute(const MonthViewPageDemo()),
              child: Text(AppLocalizations.of(context)!.vistaMensual),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => context.pushRoute(const DayViewPageDemo()),
              child: Text(AppLocalizations.of(context)!.vistaDiara),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => context.pushRoute(const WeekViewDemo()),
              child: Text(AppLocalizations.of(context)!.vistaSemanal),
            ),
          ],
        ),
      ),
    );
  }
}
