// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

enum TipoBeneficio {
  FAMILIAR,
  LABORAL,
  CONVENIO,
  OCASIONAL;

  @override
  String toString() {
    return name;
  }

  IconData get icon {
    switch (this) {
      case TipoBeneficio.FAMILIAR:
        return Icons.family_restroom;
      case TipoBeneficio.LABORAL:
        return Icons.work;
      case TipoBeneficio.CONVENIO:
        return Icons.favorite;
      case TipoBeneficio.OCASIONAL:
        return Icons.sentiment_satisfied;
      default:
        return Icons.fiber_manual_record;
    }
  }
}
