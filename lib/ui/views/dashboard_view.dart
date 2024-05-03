import 'package:agenda_front/constants.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultSizing),
          child: Center(
              child: Text('Inicio',
                  style: Theme.of(context).textTheme.titleLarge)),
        ),
      ],
    );
  }
}
