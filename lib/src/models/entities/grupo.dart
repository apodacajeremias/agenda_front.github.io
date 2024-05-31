import 'package:agenda_front/src/models/entities/beneficio.dart';
import 'package:agenda_front/src/models/entities/persona.dart';

class Grupo {
  String id;
  bool activo;
  String nombre;
  DateTime fechaCreacion;

  List<Persona>? personas;
  Beneficio? beneficio;

  Grupo({
    required this.id,
    required this.activo,
    required this.nombre,
    required this.fechaCreacion,
    this.personas,
    this.beneficio,
  });

  factory Grupo.fromJson(Map<String, dynamic> json) => Grupo(
        id: json['id'],
        activo: json['activo'],
        nombre: json['nombre'],
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
