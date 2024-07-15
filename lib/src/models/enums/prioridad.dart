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
        return Colors.blue[100]!;
      case Prioridad.MEDIA:
        return Colors.yellow[100]!;
      case Prioridad.ALTA:
        return Colors.orange[200]!;
      case Prioridad.URGENTE:
        return Colors.red[300]!;
      default:
        return Colors.grey[50]!;
    }
  }

  IconData get icon {
    switch (this) {
      case Prioridad.BAJA:
        return Icons.circle;
      case Prioridad.MEDIA:
        return Icons.priority_high;
      case Prioridad.ALTA:
        return Icons.warning;
      case Prioridad.URGENTE:
        return Icons.emergency_rounded;
      default:
        return Icons.circle;
    }
  }
}
