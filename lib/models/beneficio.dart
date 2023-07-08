// To parse this JSON data, do
//
//     final agenda = agendaFromJson(jsonString);

import 'dart:convert';

import 'package:agenda_front/models/enums/tipo_beneficio.dart';
import 'package:agenda_front/models/enums/tipo_descuento.dart';
import 'package:agenda_front/models/promocion.dart';

Beneficio beneficioFromJson(String str) => Beneficio.fromJson(json.decode(str));

String beneficioToJson(Beneficio data) => json.encode(data.toJson());

class Beneficio {
  String? id;
  bool? activo;
  String? nombre;
  DateTime? fechaCreacion;
  DateTime? fechaModificacion;
  TipoBeneficio? tipo;
  TipoDescuento? tipoDescuento;
  double? descuento;
  List<Promocion>? promociones;

  Beneficio(
      {this.id,
      this.activo,
      this.nombre,
      this.fechaCreacion,
      this.fechaModificacion,
      this.tipo,
      this.tipoDescuento,
      this.descuento,
      this.promociones});

  factory Beneficio.fromJson(Map<String, dynamic> json) => Beneficio(
        id: json["id"],
        activo: json["activo"],
        nombre: json["nombre"],
        fechaCreacion: DateTime.parse(json['fechaCreacion']),
        fechaModificacion: DateTime.parse(json['fechaModificacion']),
        tipo: TipoBeneficio.values[json['tipo']],
        tipoDescuento: TipoDescuento.values[json['tipoDescuento']],
        descuento: json['descuento'],
        promociones: json['promociones'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "activo": activo,
        "nombre": nombre,
        "tipo": tipo.toString().toUpperCase(),
        "tipoDescuento": tipoDescuento.toString().toUpperCase(),
        "descuento": descuento,
      };
}
