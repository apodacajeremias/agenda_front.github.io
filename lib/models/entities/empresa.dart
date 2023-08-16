// To parse this JSON data, do
//
//     final empresa = empresaFromJson(jsonString);

import 'dart:convert';

import 'package:agenda_front/models/enums/idioma.dart';
import 'package:agenda_front/models/enums/moneda.dart';

Empresa empresaFromJson(String str) => Empresa.fromJson(json.decode(str));

String empresaToJson(Empresa data) => json.encode(data.toJson());

class Empresa {
  String? id;
  bool? activo;
  String? nombre;
  DateTime? fechaCreacion;
  DateTime? fechaModificacion;
  String? celular;
  String? telefono;
  DateTime? fechaInauguracion;
  String? direccion;
  String? registroContribuyente;
  String? logo;
  Moneda? moneda;
  Idioma? idioma;

  Empresa(
      {this.id,
      this.activo,
      this.nombre,
      this.fechaCreacion,
      this.fechaModificacion,
      this.celular,
      this.telefono,
      this.fechaInauguracion,
      this.direccion,
      this.registroContribuyente,
      this.logo,
      this.moneda,
      this.idioma});

  factory Empresa.fromJson(Map<String, dynamic> json) => Empresa(
        id: json['id'],
        activo: json['activo'],
        nombre: json['nombre'],
        fechaCreacion: DateTime.tryParse(json['fechaCreacion']),
        fechaModificacion: DateTime.tryParse(json['fechaModificacion']),
        celular: json['celular'],
        telefono: json['telefono'],
        fechaInauguracion: DateTime.tryParse(json['fechaInauguracion']),
        direccion: json['direccion'],
        registroContribuyente: json['registroContribuyente'],
        logo: json['logo'],
        moneda: Moneda.values.byName(json['moneda']),
        idioma: Idioma.values.byName(json['idioma']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'activo': activo,
        'nombre': nombre,
        'celular': celular,
        'telefono': telefono,
        'fechaInauguracion': fechaInauguracion?.toIso8601String(),
        'direccion': direccion,
        'registroContribuyente': registroContribuyente,
        'logo': logo,
        'moneda': moneda.toString().toUpperCase(),
        'idioma': idioma.toString().toUpperCase()
      };

  @override
  String toString() {
    return nombre ?? 'N/A';
  }
}
