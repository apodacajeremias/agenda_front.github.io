// To parse this JSON data, do
//
//     final agenda = agendaFromJson(jsonString);

import 'dart:convert';

import 'package:agenda_front/models/enums/tipo_transaccion.dart';

Item itemFromJson(String str) => Item.fromJson(json.decode(str));

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
  String? id;
  bool? activo;
  String? nombre;
  DateTime? fechaCreacion;
  DateTime? fechaModificacion;
  double? precio;
  TipoTransaccion? tipo;

  Item({
    this.id,
    this.activo,
    this.nombre,
    this.fechaCreacion,
    this.fechaModificacion,
    this.precio,
    this.tipo,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
      id: json['id'],
      activo: json['activo'],
      nombre: json['nombre'],
      fechaCreacion: DateTime.parse(json['fechaCreacion']),
      fechaModificacion: DateTime.parse(json['fechaModificacion']),
      precio: json['precio'],
      tipo: TipoTransaccion.values[json['tipo']]);

  Map<String, dynamic> toJson() => {
        'id': id,
        'activo': activo,
        'nombre': nombre,
        'precio': precio,
        'tipo': tipo.toString().toUpperCase(),
      };
}
