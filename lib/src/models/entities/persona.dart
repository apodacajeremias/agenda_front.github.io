import 'package:agenda_front/src/models/entities/colaborador.dart';
import 'package:agenda_front/src/models/entities/grupo.dart';
import 'package:agenda_front/src/models/enums/genero.dart';
import 'package:agenda_front/src/models/security/user.dart';

class Persona {
  String id;
  bool? activo;
  String nombre;
  String? observacion;
  DateTime fechaCreacion;

  String documentoIdentidad;
  DateTime fechaNacimiento;
  int edad;
  Genero genero;
  String? telefono;
  String? celular;
  String? direccion;
  String? fotoPerfil;
  Colaborador? colaborador;
  User? user;
  List<Grupo>? grupos;

  Persona({
    required this.id,
    this.activo,
    required this.nombre,
    this.observacion,
    required this.fechaCreacion,
    required this.documentoIdentidad,
    required this.fechaNacimiento,
    required this.edad,
    required this.genero,
    this.telefono,
    this.celular,
    this.direccion,
    this.fotoPerfil,
    this.colaborador,
    this.user,
    this.grupos,
  });

  factory Persona.fromJson(Map<String, dynamic> json) => Persona(
      id: json['id'],
      activo: json['activo'],
      nombre: json['nombre'],
      observacion: json['observacion'],
      fechaCreacion: DateTime.parse(json['fechaCreacion']),
      documentoIdentidad: json['documentoIdentidad'],
      fechaNacimiento: DateTime.parse(json['fechaNacimiento']),
      edad: json['edad'],
      genero: Genero.values.byName(json['genero']),
      telefono: json['telefono'],
      celular: json['celular'],
      direccion: json['direccion'],
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
          : null);

  @override
  String toString() {
    return nombre;
  }
}
