import 'dart:convert';

import 'package:agenda_front/models/entities/colaborador.dart';
import 'package:agenda_front/models/entities/persona.dart';
import 'package:agenda_front/models/enums/prioridad.dart';
import 'package:agenda_front/models/enums/situacion.dart';

Agenda agendaFromJson(String str) => Agenda.fromJson(json.decode(str));

String agendaToJson(Agenda data) => json.encode(data.toJson());

class Agenda {
  String id;
  bool? activo;
  String? nombre;
  DateTime? inicio;
  DateTime? fin;
  bool? diaCompleto;
  Situacion? situacion;
  Prioridad? prioridad;
  Colaborador? colaborador;
  Persona? persona;
  Agenda({
    required this.id,
    this.activo,
    this.nombre,
    required this.inicio,
    required this.fin,
    this.diaCompleto,
    this.situacion,
    this.prioridad,
    this.colaborador,
    this.persona,
  });

  factory Agenda.fromJson(Map<String, dynamic> json) => Agenda(
        id: json['id'],
        activo: json['activo'],
        nombre: json['nombre'],
        inicio: DateTime.parse(json['inicio']),
        fin: DateTime.parse(json['fin']),
        diaCompleto: json['diaCompleto'],
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
        'inicio': inicio?.toIso8601String(),
        'fin': fin?.toIso8601String(),
        'diaCompleto': diaCompleto,
        'situacion': situacion,
        'prioridad': prioridad,
        'colaborador': colaborador?.toJson(),
        'persona': persona?.toJson(),
      };

  @override
  String toString() {
    return nombre ?? 'N/A';
  }
}
