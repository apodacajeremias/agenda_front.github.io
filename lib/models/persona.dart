// To parse this JSON data, do
//
//     final persona = personaFromJson(jsonString);

import 'dart:convert';

import 'package:agenda_front/models/colaborador.dart';
import 'package:agenda_front/models/user.dart';

List<Persona> personaFromJson(String str) => List<Persona>.from(json.decode(str).map((x) => Persona.fromJson(x)));

String personaToJson(List<Persona> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Persona {
    Persona({
        required this.activo,
        required this.fechaCreacion,
        required this.fechaModificacion,
        required this.nombre,
        required this.fechaNacimiento,
        required this.edad,
        required this.genero,
        required this.documentoIdentidad,
        required this.telefono,
        this.celular,
        this.correo,
        this.direccion,
        this.observacion,
        this.fotoPerfil,
        this.colaborador,
        this.user,
        required this.id,
    });

    bool activo;
    DateTime fechaCreacion;
    DateTime fechaModificacion;
    String nombre;
    DateTime fechaNacimiento;
    int edad;
    String genero;
    String documentoIdentidad;
    String telefono;
    String? celular;
    String? correo;
    dynamic direccion;
    dynamic observacion;
    dynamic fotoPerfil;
    Colaborador? colaborador;
    User? user;
    String id;

    factory Persona.fromJson(Map<String, dynamic> json) => Persona(
        activo: json["activo"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        fechaModificacion: DateTime.parse(json["fechaModificacion"]),
        nombre: json["nombre"],
        fechaNacimiento: DateTime.parse(json["fechaNacimiento"]),
        edad: json["edad"],
        genero: json["genero"],
        documentoIdentidad: json["documentoIdentidad"],
        telefono: json["telefono"],
        celular: json["celular"],
        correo: json["correo"],
        direccion: json["direccion"],
        observacion: json["observacion"],
        fotoPerfil: json["fotoPerfil"],
        colaborador: json["colaborador"] == null ? null : Colaborador.fromJson(json["colaborador"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "activo": activo,
        "fechaCreacion": fechaCreacion.toIso8601String(),
        "fechaModificacion": fechaModificacion.toIso8601String(),
        "nombre": nombre,
        "fechaNacimiento": "${fechaNacimiento.year.toString().padLeft(4, '0')}-${fechaNacimiento.month.toString().padLeft(2, '0')}-${fechaNacimiento.day.toString().padLeft(2, '0')}",
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
        "user": user?.toJson(),
        "id": id,
    };
}

