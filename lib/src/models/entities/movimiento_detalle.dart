import 'package:agenda_front/src/models/entities/movimiento.dart';
import 'package:agenda_front/src/models/entities/transaccion.dart';

class MovimientoDetalle {
  final String id;
  final bool activo;
  final String nombre;
  final DateTime fechaCreacion;

  final double subtotal;
  final Movimiento movimiento;
  final Transaccion transaccion;

  MovimientoDetalle(
      {required this.id,
      required this.activo,
      required this.nombre,
      required this.fechaCreacion,
      required this.subtotal,
      required this.movimiento,
      required this.transaccion});

  factory MovimientoDetalle.fromJson(Map<String, dynamic> json) =>
      MovimientoDetalle(
        id: json['id'],
        activo: json['activo'],
        nombre: json['nombre'],
        fechaCreacion: DateTime.parse(json['fechaCreacion']),
        subtotal: json['subtotal'],
        movimiento: Movimiento.fromJson(json['movimiento']),
        transaccion: Transaccion.fromJson(json['transaccion']),
      );

  @override
  String toString() {
    return id;
  }
}
