// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:math';

import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: buildBoxDecoration(),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Image(image: AssetImage('logo.png'), width: 400),
          ),
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    String assetBackground = _buildAsset('background', 13) + '.jpg';
    return BoxDecoration(
        image: DecorationImage(
            image: AssetImage(assetBackground), fit: BoxFit.cover));
  }

  _buildAsset(String asset, int max, {int min = 1}) {
    int random = Random().nextInt(max) + min;
    return '$asset-$random';
  }
}
