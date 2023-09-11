import 'package:agenda_front/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:agenda_front/ui/cards/white_card.dart';

import 'package:agenda_front/providers/auth_provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final persona = Provider.of<AuthProvider>(context).persona!;
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Inicio', style: Theme.of(context).textTheme.displayLarge),
          Text('Inicio', style: Theme.of(context).textTheme.displayMedium),
          Text('Inicio', style: Theme.of(context).textTheme.displaySmall),
          Text('Inicio', style: Theme.of(context).textTheme.headlineLarge),
          Text('Inicio', style: Theme.of(context).textTheme.headlineMedium),
          Text('Inicio', style: Theme.of(context).textTheme.headlineSmall),
          Text('Inicio', style: Theme.of(context).textTheme.titleLarge),
          Text('Inicio', style: Theme.of(context).textTheme.titleMedium),
          Text('Inicio', style: Theme.of(context).textTheme.titleSmall),
          Text('Inicio', style: Theme.of(context).textTheme.bodyLarge),
          Text('Inicio', style: Theme.of(context).textTheme.bodyMedium),
          Text('Inicio', style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: defaultPadding),
          WhiteCard(
              // title: persona.nombre,
              child: Text(persona.id!))
        ],
      ),
    );
  }
}
