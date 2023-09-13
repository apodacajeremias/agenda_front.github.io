import 'dart:math';

import 'package:agenda_front/constants.dart';
import 'package:agenda_front/ui/cards/white_card.dart';
import 'package:agenda_front/ui/shared/my_header.dart';
import 'package:flutter/material.dart';

class NoInfoCard extends StatelessWidget {
  /// Titulo: puede ser nulo
  final String? title;
  const NoInfoCard({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (title != null) ...[MyHeader(title: title!)],
      WhiteCard(
          child: Column(
        children: [
          Center(child: _buildImage()),
          const SizedBox(height: defaultPadding),
          const Text('No se ha encontrado información.')
        ],
      )),
    ]);
  }

  Image _buildImage() {
    String asset = _buildAsset('empty', 2) + '.png';
    return Image.asset(asset);
  }

  _buildAsset(String asset, int max, {int min = 1}) {
    int random = Random().nextInt(max) + min;
    return '$asset-$random';
  }
}
