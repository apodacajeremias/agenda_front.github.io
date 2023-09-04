import 'package:agenda_front/constants.dart';
import 'package:flutter/material.dart';

import 'package:agenda_front/ui/cards/white_card.dart';

class BlankView extends StatelessWidget {
  const BlankView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: const [
          Text('Blank View'),
          SizedBox(height: defaultPadding),
          WhiteCard(title: 'Blank Page', child: Text('Hola Mundo!!'))
        ],
      ),
    );
  }
}
