// To parse this JSON data, do
//
//     final persona = personaFromJson(jsonString);

import 'dart:convert';

import 'package:agenda_front/models/entities/colaborador.dart';
import 'package:agenda_front/models/entities/grupo.dart';
import 'package:agenda_front/models/enums/genero.dart';

Persona personaFromJson(String str) => Persona.fromJson(json.decode(str));

String personaToJson(Persona data) => json.encode(data.toJson());

class Persona {
  String? id;
  bool? activo;
  String? nombre;
  DateTime? fechaCreacion;
  DateTime? fechaModificacion;
  String? documentoIdentidad;
  DateTime? fechaNacimiento;
  Genero? genero;
  String? telefono;
  String? celular;
  String? direccion;
  String? observacion;
  String? fotoPerfil;
  Colaborador? colaborador;
  List<Grupo>? grupos;

  Persona({
    this.id,
    this.activo,
    this.nombre,
    this.fechaCreacion,
    this.fechaModificacion,
    this.documentoIdentidad,
    this.fechaNacimiento,
    this.genero,
    this.telefono,
    this.celular,
    this.direccion,
    this.observacion,
    this.fotoPerfil,
    this.colaborador,
    this.grupos,
  });

  factory Persona.fromJson(Map<String, dynamic> json) => Persona(
        id: json['id'],
        activo: json['activo'],
        nombre: json['nombre'],
        fechaCreacion: DateTime.parse(json['fechaCreacion']),
        fechaModificacion: DateTime.parse(json['fechaModificacion']),
        documentoIdentidad: json['documentoIdentidad'],
        fechaNacimiento: DateTime.parse(json['fechaNacimiento']),
        genero: Genero.values.byName(json['genero']),
        telefono: json['telefono'],
        celular: json['celular'],
        direccion: json['direccion'],
        observacion: json['observacion'],
        fotoPerfil: json['fotoPerfil'],
        grupos: List.from(json['grupos']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'activo': activo,
        'nombre': nombre,
        'documentoIdentidad': documentoIdentidad,
        'fechaNacimiento': fechaNacimiento?.toIso8601String(),
        'genero': genero.toString().toUpperCase(),
        'telefono': telefono,
        'celular': celular,
        'direccion': direccion,
        'observacion': observacion,
        'fotoPerfil': fotoPerfil,
        'colaborador': colaborador?.toJson(),
        'grupos': grupos
      };
}
