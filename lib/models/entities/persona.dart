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
        documentoIdentidad: json['documentoIdentidad'],
        fechaNacimiento: DateTime.tryParse(json['fechaNacimiento']),
        genero: Genero.values.byName(json['genero']),
        telefono: json['telefono'],
        celular: json['celular'],
        direccion: json['direccion'],
        observacion: json['observacion'],
        fotoPerfil: json['fotoPerfil'],
        colaborador:
            json.containsKey('colaborador') && json['colaborador'] != null
                ? Colaborador.fromJson(json['colaborador'])
                : null,
        grupos: json.containsKey('grupos') && json['grupos'] != null
            ? List.from(json['grupos'].map((g) => Grupo.fromJson(g)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'activo': activo,
        'nombre': nombre,
        'documentoIdentidad': documentoIdentidad,
        'fechaNacimiento': fechaNacimiento?.toIso8601String(),
        'genero': genero,
        'telefono': telefono,
        'celular': celular,
        'direccion': direccion,
        'observacion': observacion,
        'fotoPerfil': fotoPerfil,
        'colaborador': colaborador?.toJson(),
        'grupos': grupos
      };

  @override
  String toString() {
    return nombre ?? 'N/A';
  }
}
