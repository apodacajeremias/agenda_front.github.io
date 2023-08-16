// To parse this JSON data, do
//
//     final agenda = agendaFromJson(jsonString);

import 'dart:convert';

import 'package:agenda_front/models/entities/item.dart';
import 'package:agenda_front/models/entities/transaccion.dart';

TransaccionDetalle transaccionDetalleFromJson(String str) =>
    TransaccionDetalle.fromJson(json.decode(str));

String transaccionDetalleToJson(TransaccionDetalle data) =>
    json.encode(data.toJson());

class TransaccionDetalle {
  String? id;
  bool? activo;
  String? nombre;
  DateTime? fechaCreacion;
  DateTime? fechaModificacion;
  double? valor;
  double? cantidad;
  double? subtotal;
  Transaccion? transaccion;
  Item? item;

  TransaccionDetalle({
    this.id,
    this.activo,
    this.nombre,
    this.fechaCreacion,
    this.fechaModificacion,
    this.valor,
    this.cantidad,
    this.subtotal,
    this.transaccion,
    this.item,
  });

  factory TransaccionDetalle.fromJson(Map<String, dynamic> json) =>
      TransaccionDetalle(
        id: json['id'],
        activo: json['activo'],
        nombre: json['nombre'],
        fechaCreacion: DateTime.tryParse(json['fechaCreacion']),
        fechaModificacion: DateTime.tryParse(json['fechaModificacion']),
        valor: json['valor'],
        cantidad: json['cantidad'],
        subtotal: json['subtotal'],
        transaccion:
            (json.containsKey('transaccion') && json['transaccion'] != null)
                ? Transaccion.fromJson(json['transaccion'])
                : null,
        item: (json.containsKey('item') && json['item'] != null)
            ? Item.fromJson(json['item'])
            : null,
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'activo': activo,
        'nombre': nombre,
        'valor': valor,
        'cantidad': cantidad,
        'subtotal': subtotal,
        'transaccion': transaccion?.toJson(),
        'item': item?.toJson(),
      };

  @override
  String toString() {
    return id ?? 'N/A';
  }
}
