// To parse this JSON data, do
//
//     final agenda = agendaFromJson(jsonString);

import 'dart:convert';

import 'package:agenda_front/models/colaborador.dart';

Agenda agendaFromJson(String str) => Agenda.fromJson(json.decode(str));

String agendaToJson(Agenda data) => json.encode(data.toJson());

class Agenda {
  bool? activo;
  DateTime? fechaCreacion;
  DateTime? fechaModificacion;
  String? nombre;
  DateTime? fechaNacimiento;
  int? edad;
  String? genero;
  String? documentoIdentidad;
  String? telefono;
  String? celular;
  String? correo;
  String? direccion;
  String? observacion;
  String? fotoPerfil;
  Colaborador? colaborador;
  String? id;
  Agenda({
    this.activo,
    this.fechaCreacion,
    this.fechaModificacion,
    this.nombre,
    this.fechaNacimiento,
    this.edad,
    this.genero,
    this.documentoIdentidad,
    this.telefono,
    this.celular,
    this.correo,
    this.direccion,
    this.observacion,
    this.fotoPerfil,
    this.colaborador,
    this.id,
  });

  factory Agenda.fromJson(Map<String, dynamic> json) => Agenda(
        activo: json["activo"],
        nombre: json["nombre"],
        fechaNacimiento: DateTime.parse(json["fechaNacimiento"].toString()),
        edad: json["edad"],
        genero: json["genero"],
        documentoIdentidad: json["documentoIdentidad"],
        telefono: json["telefono"],
        celular: json["celular"],
        correo: json["correo"],
        direccion: json["direccion"],
        observacion: json["observacion"],
        fotoPerfil: json["fotoPerfil"],
        colaborador:
            (json.containsKey('colaborador') && json['colaborador'] != null)
                ? Colaborador.fromJson(json["colaborador"])
                : null,
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "activo": activo,
        "fechaCreacion": fechaCreacion?.toIso8601String(),
        "fechaModificacion": fechaModificacion,
        "nombre": nombre,
        "fechaNacimiento":
            "${fechaNacimiento!.year.toString().padLeft(4, '0')}-${fechaNacimiento!.month.toString().padLeft(2, '0')}-${fechaNacimiento!.day.toString().padLeft(2, '0')}",
        "edad": edad,
        "genero": genero,
        "documentoIdentidad": documentoIdentidad,
        "telefono": telefono,
        "celular": celular,
        "correo": correo,
        "direccion": direccion,
        "observacion": observacion,
        "fotoPerfil": fotoPerfil,
        "colaborador": colaborador?.toJson(),
        "id": id,
      };
}
