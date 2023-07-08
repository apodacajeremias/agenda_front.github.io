// To parse this JSON data, do
//
//     final agenda = agendaFromJson(jsonString);

import 'dart:convert';

import 'package:agenda_front/models/entities/beneficio.dart';
import 'package:agenda_front/models/entities/persona.dart';

Grupo grupoFromJson(String str) => Grupo.fromJson(json.decode(str));

String grupoToJson(Grupo data) => json.encode(data.toJson());

class Grupo {
  String? id;
  bool? activo;
  String? nombre;
  DateTime? fechaCreacion;
  DateTime? fechaModificacion;
  List<Persona>? personas;
  Beneficio? beneficio;

  Grupo({
    this.id,
    this.activo,
    this.nombre,
    this.fechaCreacion,
    this.fechaModificacion,
    this.personas,
    this.beneficio,
  });

  factory Grupo.fromJson(Map<String, dynamic> json) => Grupo(
        id: json['id'],
        activo: json['activo'],
        nombre: json['nombre'],
        fechaCreacion: DateTime.parse(json['fechaCreacion']),
        fechaModificacion: DateTime.parse(json['fechaModificacion']),
        personas: json['personas'],
        beneficio: Beneficio.fromJson(json['promociones']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'activo': activo,
        'nombre': nombre,
        'personas': personas,
        'beneficio': beneficio?.toJson(),
      };
}
