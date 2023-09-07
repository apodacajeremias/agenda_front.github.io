// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum Genero {
  MASCULINO,
  FEMENINO,
  OTRO;

  @override
  String toString() {
    return name;
  }

  IconData get icon {
    switch (this) {
      case Genero.MASCULINO:
        return Icons.male_outlined;
      case Genero.FEMENINO:
        return Icons.female_outlined;
      default:
        return Icons.transgender_outlined;
    }
  }
}
