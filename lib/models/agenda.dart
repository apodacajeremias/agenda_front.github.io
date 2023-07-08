// To parse this JSON data, do
//
//     final agenda = agendaFromJson(jsonString);

import 'dart:convert';

import 'package:agenda_front/models/colaborador.dart';
import 'package:agenda_front/models/enums/prioridad.dart';
import 'package:agenda_front/models/enums/situacion.dart';
import 'package:agenda_front/models/persona.dart';

Agenda agendaFromJson(String str) => Agenda.fromJson(json.decode(str));

String agendaToJson(Agenda data) => json.encode(data.toJson());

class Agenda {
  String? id;
  bool? activo;
  String? nombre;
  DateTime? fechaCreacion;
  DateTime? fechaModificacion;
  DateTime? fecha;
  DateTime? hora;
  String? observacion;
  Situacion? situacion;
  Prioridad? prioridad;
  Colaborador? colaborador;
  Persona? persona;
  Agenda({
    this.id,
    this.activo,
    this.nombre,
    this.fechaCreacion,
    this.fechaModificacion,
    this.fecha,
    this.hora,
    this.observacion,
    this.situacion,
    this.prioridad,
    this.colaborador,
    this.persona,
  });

  factory Agenda.fromJson(Map<String, dynamic> json) => Agenda(
        id: json["id"],
        activo: json["activo"],
        nombre: json["nombre"],
        fechaCreacion: DateTime.parse(json['fechaCreacion']),
        fechaModificacion: DateTime.parse(json['fechaModificacion']),
        fecha: DateTime.parse(json['fecha']),
        hora: DateTime.parse(json['hora']),
        observacion: json["observacion"],
        situacion: Situacion.values[json["situacion"]],
        prioridad: Prioridad.values[json["prioridad"]],
        colaborador:
            (json.containsKey('colaborador') && json['colaborador'] != null)
                ? Colaborador.fromJson(json["colaborador"])
                : null,
        persona: (json.containsKey('persona') && json['persona'] != null)
            ? Persona.fromJson(json['persona'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "activo": activo,
        "nombre": nombre,
        "fecha": fecha,
        "hora": hora,
        "observacion": observacion,
        "situacion": situacion.toString().toUpperCase(),
        "prioridad": prioridad.toString().toUpperCase(),
        "colaborador": colaborador?.toJson(),
        "persona": persona?.toJson(),
      };
}
