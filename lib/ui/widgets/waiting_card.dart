import 'package:agenda_front/constants.dart';
import 'package:agenda_front/ui/widgets/header.dart';
import 'package:agenda_front/ui/widgets/white_card.dart';
import 'package:flutter/material.dart';

class WaitingCard extends StatelessWidget {
  final String? title;
  const WaitingCard({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (title != null) ...[Header(title: title!)],
      WhiteCard(
          child: Column(
        children: [
          Center(
              child: SizedBox.square(
                  dimension: 256, child: Image.asset('loader.gif'))),
          const SizedBox(height: defaultSizing),
          const Text('Buscando...')
        ],
      )),
    ]);
  }
}
