// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: AssetImage('logo.png'),
            width: 50,
            height: 50,
          ),
          SizedBox(height: 20),
          FittedBox(
            fit: BoxFit.contain,
            child: Text('Bienvenido',
                style: Theme.of(context).textTheme.bodySmall),
          )
        ],
      ),
    );
  }

  _buildAsset(String asset, int max, {int min = 1}) {
    int random = Random().nextInt(max) + min;
    return '$asset-$random';
  }
}
