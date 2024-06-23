import 'package:flutter/material.dart';

class HorarioDisponible {
  DateTime inicio;
  DateTime fin;
  HorarioDisponible({
    required this.inicio,
    required this.fin,
  });

  factory HorarioDisponible.fromJson(Map<String, dynamic> json) =>
      HorarioDisponible(
        inicio: DateTime.parse(json['inicio']),
        fin: DateTime.parse(json['fin']),
      );
  String toHourMinute(BuildContext context) {
    final tInicio = TimeOfDay.fromDateTime(inicio);
    final tFin = TimeOfDay.fromDateTime(fin);
    return '${tInicio.format(context)} → ${tFin.format(context)}';
  }
}
