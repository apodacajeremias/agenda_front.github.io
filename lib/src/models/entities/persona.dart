import 'dart:convert';

import 'package:agenda_front/src/models/entities/colaborador.dart';
import 'package:agenda_front/src/models/entities/grupo.dart';
import 'package:agenda_front/src/models/enums/genero.dart';
import 'package:agenda_front/src/models/security/user.dart';

Persona personaFromJson(String str) => Persona.fromJson(json.decode(str));

String personaToJson(Persona data) => json.encode(data.toJson());

class Persona {
  String? id;
  bool? activo;
  String? nombre;

  String? documentoIdentidad;
  DateTime fechaNacimiento;
  int? edad;
  Genero? genero;
  String? telefono;
  String? celular;
  String? direccion;
  String? observacion;
  String? fotoPerfil;
  Colaborador? colaborador;
  User? user;
  List<Grupo>? grupos;

  Persona({
    this.id,
    this.activo,
    this.nombre,
    this.documentoIdentidad,
    required this.fechaNacimiento,
    this.edad,
    this.genero,
    this.telefono,
    this.celular,
    this.direccion,
    this.observacion,
    this.fotoPerfil,
    this.colaborador,
    this.user,
    this.grupos,
  });

  factory Persona.fromJson(Map<String, dynamic> json) => Persona(
      id: json['id'],
      activo: json['activo'],
      nombre: json['nombre'],
      documentoIdentidad: json['documentoIdentidad'],
      fechaNacimiento: DateTime.tryParse(json['fechaNacimiento'])!,
      edad: json['edad'],
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
      user: json.containsKey('user') && json['user'] != null
          ? User.fromJson(json['user'])
          : null,
      grupos: json.containsKey('grupos') && json['grupos'] != null
          ? List.from(json['grupos'].map((g) => Grupo.fromJson(g)))
          : List.empty());

  Map<String, dynamic> toJson() => {
        'id': id,
        'activo': activo,
        'nombre': nombre,
        'documentoIdentidad': documentoIdentidad,
        'fechaNacimiento': fechaNacimiento.toIso8601String(),
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
