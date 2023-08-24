// To parse this JSON data, do
//
//     final agenda = agendaFromJson(jsonString);

import 'dart:convert';

import 'package:agenda_front/models/entities/promocion.dart';
import 'package:agenda_front/models/enums/tipo_beneficio.dart';
import 'package:agenda_front/models/enums/tipo_descuento.dart';

Beneficio beneficioFromJson(String str) => Beneficio.fromJson(json.decode(str));

String beneficioToJson(Beneficio data) => json.encode(data.toJson());

class Beneficio {
  String? id;
  bool? activo;
  String? nombre;

  TipoBeneficio? tipo;
  TipoDescuento? tipoDescuento;
  double? descuento;
  List<Promocion>? promociones;

  Beneficio(
      {this.id,
      this.activo,
      this.nombre,
      this.tipo,
      this.tipoDescuento,
      this.descuento,
      this.promociones});

  factory Beneficio.fromJson(Map<String, dynamic> json) => Beneficio(
        id: json['id'],
        activo: json['activo'],
        nombre: json['nombre'],
        tipo: TipoBeneficio.values.byName(json['tipo']),
        tipoDescuento: TipoDescuento.values.byName(json['tipoDescuento']),
        descuento: json['descuento'],
        promociones: json.containsKey('promociones') &&
                json['promociones'] != null
            ? List<Promocion>.from(
                json['promociones'].map((model) => Promocion.fromJson(model)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'activo': activo,
        'nombre': nombre,
        'tipo': tipo,
        'tipoDescuento': tipoDescuento,
        'descuento': descuento,
      };

  @override
  String toString() {
    return nombre ?? 'N/A';
  }
}
