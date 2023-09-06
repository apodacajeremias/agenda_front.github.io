// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

enum TipoDescuento {
  VALOR,
  PORCENTAJE;

  @override
  String toString() {
    return name;
  }

  IconData get icon {
    switch (this) {
      case TipoDescuento.VALOR:
        return Icons.tag;
      case TipoDescuento.PORCENTAJE:
        return Icons.percent;
      default:
        return Icons.fiber_manual_record;
    }
  }
}
