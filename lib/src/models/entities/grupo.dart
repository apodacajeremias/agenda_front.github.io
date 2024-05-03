// To parse this JSON data, do
//
//     final agenda = agendaFromJson(jsonString);

import 'dart:convert';

import 'package:agenda_front/src/models/entities/beneficio.dart';
import 'package:agenda_front/src/models/entities/persona.dart';

Grupo grupoFromJson(String str) => Grupo.fromJson(json.decode(str));

String grupoToJson(Grupo data) => json.encode(data.toJson());

class Grupo {
  String? id;
  bool? activo;
  String? nombre;

  List<Persona>? personas;
  Beneficio? beneficio;

  Grupo({
    this.id,
    this.activo,
    this.nombre,
    this.personas,
    this.beneficio,
  });

  factory Grupo.fromJson(Map<String, dynamic> json) => Grupo(
        id: json['id'],
        activo: json['activo'],
        nombre: json['nombre'],
        personas: json['personas'],
        beneficio: json.containsKey('beneficio') && json['beneficio'] != null
            ? Beneficio.fromJson(json['beneficio'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'activo': activo,
        'nombre': nombre,
        'personas': personas,
        'beneficio': beneficio?.toJson(),
      };

  @override
  String toString() {
    return nombre ?? 'N/A';
  }
}
