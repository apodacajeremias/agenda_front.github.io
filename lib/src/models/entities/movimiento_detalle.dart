import 'package:agenda_front/src/models/entities/movimiento.dart';
import 'package:agenda_front/src/models/entities/transaccion.dart';

class MovimientoDetalle {
  String id;
  bool? estado;
  String nombre;
  String? observacion;
  DateTime fechaCreacion;

  final double subtotal;
  final Movimiento? movimiento;
  final Transaccion transaccion;

  MovimientoDetalle({
    required this.id,
    this.estado,
    required this.nombre,
    this.observacion,
    required this.fechaCreacion,
    required this.subtotal,
    this.movimiento,
    required this.transaccion,
  });

  factory MovimientoDetalle.fromJson(Map<String, dynamic> json) =>
      MovimientoDetalle(
        id: json['id'],
        estado: json['estado'],
        nombre: json['nombre'],
        observacion: json['observacion'],
        fechaCreacion: DateTime.parse(json['fechaCreacion']),
        subtotal: json['subtotal'],
        transaccion: Transaccion.fromJson(json['transaccion']),
      );

  @override
  String toString() {
    return id;
  }
}
