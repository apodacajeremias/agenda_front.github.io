// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

enum Prioridad {
  BAJA,
  MEDIA,
  ALTA,
  URGENTE;

  @override
  String toString() {
    return name;
  }
}

extension PrioridadExtension on Prioridad {
  Color get color {
    switch (this) {
      case Prioridad.BAJA:
        return Colors.blue;
      case Prioridad.MEDIA:
        return Colors.yellow;
      case Prioridad.ALTA:
        return Colors.orange;
      case Prioridad.URGENTE:
        return Colors.red;
      default:
        return Colors.lightBlue;
    }
  }
}
