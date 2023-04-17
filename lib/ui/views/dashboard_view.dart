import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:agenda_front/ui/labels/custom_labels.dart';
import 'package:agenda_front/ui/cards/white_card.dart';

import 'package:agenda_front/providers/auth_provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user!;
    final persona = Provider.of<AuthProvider>(context).persona!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Dashboard View', style: CustomLabels.h1),
          const SizedBox(height: 10),
          WhiteCard(title: persona.nombre, child: Text(persona.id))
        ],
      ),
    );
  }
}
