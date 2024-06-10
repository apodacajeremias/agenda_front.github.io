import 'package:agenda_front/src/models/entities/colaborador.dart';
import 'package:agenda_front/src/models/entities/persona.dart';
import 'package:agenda_front/src/models/enums/prioridad.dart';
import 'package:agenda_front/src/models/enums/situacion.dart';

class Agenda {
  String id;
  bool? estado;
  String nombre;
  String? observacion;
  DateTime fechaCreacion;

  DateTime? inicio;
  DateTime? fin;
  bool diaCompleto;
  Situacion situacion;
  Prioridad prioridad;
  Colaborador colaborador;
  Persona persona;
  Agenda({
    required this.id,
    this.estado,
    required this.nombre,
    this.observacion,
    required this.fechaCreacion,
    required this.inicio,
    required this.fin,
    required this.diaCompleto,
    required this.situacion,
    required this.prioridad,
    required this.colaborador,
    required this.persona,
  });

  factory Agenda.fromJson(Map<String, dynamic> json) => Agenda(
        id: json['id'],
        estado: json['estado'],
        nombre: json['nombre'],
        observacion: json['observacion'],
        fechaCreacion: DateTime.parse(json['fechaCreacion']),
        inicio: DateTime.parse(json['inicio']),
        fin: DateTime.parse(json['fin']),
        diaCompleto: json['diaCompleto'],
        situacion: Situacion.values.byName(json['situacion']),
        prioridad: Prioridad.values.byName(json['prioridad']),
        colaborador: Colaborador.fromJson(json['colaborador']),
        persona: Persona.fromJson(json['persona']),
      );

  @override
  String toString() {
    return nombre;
  }
}
