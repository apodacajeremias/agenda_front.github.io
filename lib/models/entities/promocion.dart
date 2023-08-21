// To parse this JSON data, do
//
//     final agenda = agendaFromJson(jsonString);

import 'dart:convert';

import 'package:agenda_front/models/entities/beneficio.dart';
import 'package:agenda_front/models/enums/tipo_descuento.dart';

Promocion promocionFromJson(String str) => Promocion.fromJson(json.decode(str));

String promocionToJson(Promocion data) => json.encode(data.toJson());

class Promocion {
  String? id;
  bool? activo;
  String? nombre;
  DateTime? fechaCreacion;
  DateTime? fechaModificacion;
  DateTime? inicio;
  DateTime? fin;
  double? valor;
  TipoDescuento? tipoDescuento;
  List<Beneficio>? beneficios;

  Promocion({
    this.id,
    this.activo,
    this.nombre,
    this.fechaCreacion,
    this.fechaModificacion,
    this.inicio,
    this.fin,
    this.valor,
    this.tipoDescuento,
    this.beneficios,
  });

  factory Promocion.fromJson(Map<String, dynamic> json) => Promocion(
      id: json["id"],
      activo: json["activo"],
      nombre: json["nombre"],
      fechaCreacion: DateTime.tryParse(json['fechaCreacion']),
      fechaModificacion: DateTime.tryParse(json['fechaModificacion']),
      inicio: DateTime.tryParse(json['inicio']),
      fin: DateTime.tryParse(json['fin']),
      valor: json["valor"],
      tipoDescuento: TipoDescuento.values.byName(json['tipoDescuento']),
      beneficios: json['beneficios']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "activo": activo,
        "nombre": nombre,
        "inicio": inicio,
        "fin": fin,
        "valor": valor,
        "tipoDescuento": tipoDescuento,
      };

  @override
  String toString() {
    return nombre ?? 'N/A';
  }
}
