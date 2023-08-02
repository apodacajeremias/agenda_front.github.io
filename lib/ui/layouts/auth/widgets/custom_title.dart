import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Image(
            image: AssetImage('logo.png'),
            width: 50,
            height: 50,
          ),
          const SizedBox(height: 20),
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              'Bienvenido',
              style: GoogleFonts.montserratAlternates(
                  fontSize: 60,
                  color: Colors.blueGrey.shade700,
                  fontWeight: FontWeight.bold),
            ),
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
