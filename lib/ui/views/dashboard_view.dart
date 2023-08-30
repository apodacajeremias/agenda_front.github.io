import 'package:agenda_front/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:agenda_front/ui/cards/white_card.dart';

import 'package:agenda_front/providers/auth_provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final persona = Provider.of<AuthProvider>(context).usuario!.persona!;
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Inicio', style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: defaultPadding),
          WhiteCard(title: persona.nombre, child: Text(persona.id!))
        ],
      ),
    );
  }
}
