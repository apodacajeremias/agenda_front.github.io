// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

enum TipoTransaccion {
  COMPRA,
  VENTA;

  @override
  String toString() {
    return name;
  }

  IconData get icon {
    switch (this) {
      case TipoTransaccion.COMPRA:
        return Icons.paid;
      case TipoTransaccion.VENTA:
        return Icons.sell;
      default:
        return Icons.adjust;
    }
  }
}
