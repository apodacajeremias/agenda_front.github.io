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
  String id;
  bool? activo;
  String? nombre;
  DateTime? fechaCreacion;

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
    required this.id,
    this.activo,
    this.nombre,
    this.fechaCreacion,
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
        tipo: TipoTransaccion.values.byName(json['tipo']),
        total: json['total'],
        descuento: json['descuento'],
        sumatoria: json['sumatoria'],
        aplicarPromocion: json['aplicarPromocion'],
        tipoBeneficio:
            (json.containsKey('tipoBeneficio') && json['tipoBeneficio'] != null)
                ? TipoBeneficio.values.byName(json['tipoBeneficio'])
                : null,
        tipoDescuento:
            (json.containsKey('tipoDescuento') && json['tipoDescuento'] != null)
                ? TipoDescuento.values.byName(json['tipoDescuento'])
                : null,
        persona: (json.containsKey('persona') && json['persona'] != null)
            ? Persona.fromJson(json['persona'])
            : null,
        grupo: (json.containsKey('grupo') && json['grupo'] != null)
            ? Grupo.fromJson(json['grupo'])
            : null,
        beneficio: (json.containsKey('beneficio') && json['beneficio'] != null)
            ? Beneficio.fromJson(json['beneficio'])
            : null,
        detalles: (json.containsKey('detalles') && json['detalles'] != null)
            ? List.from(
                json['detalles'].map((td) => TransaccionDetalle.fromJson(td)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'activo': activo,
        'nombre': nombre,
        'tipo': tipo,
        'total': total,
        'descuento': descuento,
        'sumatoria': sumatoria,
        'aplicarPromocion': aplicarPromocion,
        'tipoBeneficio': tipoBeneficio,
        'tipoDescuento': tipoDescuento,
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
