import 'dart:math';

import 'package:agenda_front/constants.dart';
import 'package:agenda_front/ui/widgets/header.dart';
import 'package:agenda_front/ui/widgets/white_card.dart';
import 'package:flutter/material.dart';

class NoInfoCard extends StatelessWidget {
  final String? title;
  final Widget? action;
  const NoInfoCard({super.key, this.title, this.action});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (title != null) ...[Header(title: title!)],
      WhiteCard(
          footer: action,
          child: Column(
            children: [
              Center(child: _buildImage()),
              const SizedBox(height: defaultSizing),
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
