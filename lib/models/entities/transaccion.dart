// To parse this JSON data, do
//
//     final agenda = agendaFromJson(jsonString);

import 'dart:convert';

import 'package:agenda_front/models/entities/beneficio.dart';
import 'package:agenda_front/models/entities/grupo.dart';
import 'package:agenda_front/models/entities/persona.dart';
import 'package:agenda_front/models/entities/transaccion_detalle.dart';
import 'package:agenda_front/models/enums/tipo_beneficio.dart';
import 'package:agenda_front/models/enums/tipo_descuento.dart';
import 'package:agenda_front/models/enums/tipo_transaccion.dart';

Transaccion transaccionFromJson(String str) =>
    Transaccion.fromJson(json.decode(str));

String transaccionToJson(Transaccion data) => json.encode(data.toJson());

class Transaccion {
  String? id;
  bool? activo;
  String? nombre;
  DateTime? fechaCreacion;
  DateTime? fechaModificacion;
  TipoTransaccion? tipo;
  double? total;
  double? descuento;
  double? sumatoria;
  bool? aplicarPromocion;
  TipoBeneficio? tipoBeneficio;
  TipoDescuento? tipoDescuento;
  Persona? persona;
  Grupo? grupo;
  Beneficio? beneficio;
  List<TransaccionDetalle>? detalles;

  Transaccion({
    this.id,
    this.activo,
    this.nombre,
    this.fechaCreacion,
    this.fechaModificacion,
    this.tipo,
    this.total,
    this.descuento,
    this.sumatoria,
    this.aplicarPromocion,
    this.tipoBeneficio,
    this.tipoDescuento,
    this.persona,
    this.grupo,
    this.beneficio,
    this.detalles,
  });

  factory Transaccion.fromJson(Map<String, dynamic> json) => Transaccion(
        id: json['id'],
        activo: json['activo'],
        nombre: json['nombre'],
        fechaCreacion: DateTime.tryParse(json['fechaCreacion']),
        fechaModificacion: DateTime.tryParse(json['fechaModificacion']),
        tipo: TipoTransaccion.values.byName(json['tipo']),
        total: json['total'],
        descuento: json['descuento'],
        sumatoria: json['sumatoria'],
        aplicarPromocion: json['aplicarPromocion'],
        tipoBeneficio: TipoBeneficio.values.byName(json['tipoBeneficio']),
        tipoDescuento: TipoDescuento.values.byName(json['tipoDescuento']),
        persona: (json.containsKey('persona') && json['persona'] != null)
            ? Persona.fromJson(json['persona'])
            : null,
        grupo: (json.containsKey('grupo') && json['grupo'] != null)
            ? Grupo.fromJson(json['grupo'])
            : null,
        beneficio: (json.containsKey('beneficio') && json['beneficio'] != null)
            ? Beneficio.fromJson(json['beneficio'])
            : null,
        detalles: json['detalles'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'activo': activo,
        'nombre': nombre,
        'tipo': tipo.toString().toUpperCase(),
        'total': total,
        'descuento': descuento,
        'sumatoria': sumatoria,
        'aplicarPromocion': aplicarPromocion,
        'tipoBeneficio': tipoBeneficio.toString().toUpperCase(),
        'tipoDescuento': tipoDescuento.toString().toUpperCase(),
        'persona': persona?.toJson(),
        'grupo': grupo?.toJson(),
        'beneficio': beneficio?.toJson(),
        'detalles': detalles,
      };

  @override
  String toString() {
    return nombre ?? 'N/A';
  }
}
