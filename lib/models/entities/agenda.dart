// To parse this JSON data, do
//
//     final agenda = agendaFromJson(jsonString);

import 'dart:convert';

import 'package:agenda_front/models/entities/colaborador.dart';
import 'package:agenda_front/models/entities/persona.dart';
import 'package:agenda_front/models/enums/prioridad.dart';
import 'package:agenda_front/models/enums/situacion.dart';
import 'package:intl/intl.dart';

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
        id: json['id'],
        activo: json['activo'],
        nombre: json['nombre'],
        fechaCreacion: DateTime.tryParse(json['fechaCreacion']),
        fechaModificacion: DateTime.tryParse(json['fechaModificacion']),
        fecha: DateTime.tryParse(json['fecha']),
        hora: DateFormat("HH:mm:ss").parse(json['hora']),
        observacion: json['observacion'],
        situacion: Situacion.values.byName(json['situacion']),
        prioridad: Prioridad.values.byName(json['prioridad']),
        colaborador:
            (json.containsKey('colaborador') && json['colaborador'] != null)
                ? Colaborador.fromJson(json['colaborador'])
                : null,
        persona: (json.containsKey('persona') && json['persona'] != null)
            ? Persona.fromJson(json['persona'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'activo': activo,
        'nombre': nombre,
        'fecha': fecha,
        'hora': hora,
        'observacion': observacion,
        'situacion': situacion.toString().toUpperCase(),
        'prioridad': prioridad.toString().toUpperCase(),
        'colaborador': colaborador?.toJson(),
        'persona': persona?.toJson(),
      };

  @override
  String toString() {
    return nombre ?? 'N/A';
  }
}
