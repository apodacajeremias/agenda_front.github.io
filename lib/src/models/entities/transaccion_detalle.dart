// To parse this JSON data, do
//
//     final agenda = agendaFromJson(jsonString);

import 'package:agenda_front/src/models/entities/item.dart';
import 'package:agenda_front/src/models/entities/transaccion.dart';

class TransaccionDetalle {
  final String id;
  final bool activo;
  final String nombre;
  final DateTime fechaCreacion;

  final double? cantidad;
  final double? valor;
  final double? subtotal;
  final Transaccion? transaccion;
  final Item? item;

  TransaccionDetalle({
    required this.id,
    required this.activo,
    required this.nombre,
    required this.fechaCreacion,
    this.cantidad,
    this.valor,
    this.subtotal,
    this.transaccion,
    this.item,
  });

  factory TransaccionDetalle.fromJson(Map<String, dynamic> json) =>
      TransaccionDetalle(
        id: json['id'],
        activo: json['activo'],
        nombre: json['nombre'],
        fechaCreacion: DateTime.parse(json['fechaCreacion']),
        cantidad: json['cantidad'],
        valor: json['valor'],
        subtotal: json['subtotal'],
        transaccion:
            (json.containsKey('transaccion') && json['transaccion'] != null)
                ? Transaccion.fromJson(json['transaccion'])
                : null,
        item: (json.containsKey('item') && json['item'] != null)
            ? Item.fromJson(json['item'])
            : null,
      );

  @override
  String toString() {
    return id;
  }
}
