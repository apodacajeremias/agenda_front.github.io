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

  double? precio;
  TipoTransaccion? tipo;

  Item({
    this.id,
    this.activo,
    this.nombre,
    this.precio,
    this.tipo,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json['id'],
        activo: json['activo'],
        nombre: json['nombre'],
        precio: json['precio'],
        tipo: TipoTransaccion.values.byName(json['tipo']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'activo': activo,
        'nombre': nombre,
        'precio': precio,
        'tipo': tipo,
      };

  @override
  String toString() {
    return nombre ?? 'N/A';
  }
}
