import 'package:agenda_front/src/models/entities/beneficio.dart';
import 'package:agenda_front/src/models/entities/persona.dart';

class Grupo {
  String id;
  bool? estado;
  String nombre;
  String? observacion;
  DateTime fechaCreacion;

  List<Persona>? personas;
  Beneficio? beneficio;

  Grupo({
    required this.id,
    this.estado,
    required this.nombre,
    this.observacion,
    required this.fechaCreacion,
    this.personas,
    this.beneficio,
  });

  factory Grupo.fromJson(Map<String, dynamic> json) => Grupo(
        id: json['id'],
        estado: json['estado'],
        nombre: json['nombre'],
        observacion: json['observacion'],
        fechaCreacion: DateTime.parse(json['fechaCreacion']),
        personas: json['personas'],
        beneficio: json.containsKey('beneficio') && json['beneficio'] != null
            ? Beneficio.fromJson(json['beneficio'])
            : null,
      );

  @override
  String toString() {
    return nombre;
  }
}
