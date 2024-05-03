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

  Color get color {
    switch (this) {
      case Prioridad.BAJA:
        return Colors.blueAccent;
      case Prioridad.MEDIA:
        return Colors.yellowAccent;
      case Prioridad.ALTA:
        return Colors.orangeAccent;
      case Prioridad.URGENTE:
        return Colors.redAccent;
      default:
        return Colors.lightBlue;
    }
  }
}
