import 'package:agenda_front/src/models/enums/idioma.dart';
import 'package:agenda_front/src/models/enums/moneda.dart';

class Empresa {
  String id;
  bool activo;
  String nombre;
  DateTime fechaCreacion;

  String? celular;
  String? telefono;
  DateTime fechaInauguracion;
  String? direccion;
  String? registroContribuyente;
  String? logo;
  Moneda moneda;
  Idioma idioma;

  Empresa(
      {required this.id,
      required this.activo,
      required this.nombre,
      required this.fechaCreacion,
      this.celular,
      this.telefono,
      required this.fechaInauguracion,
      this.direccion,
      this.registroContribuyente,
      this.logo,
      required this.moneda,
      required this.idioma});

  factory Empresa.fromJson(Map<String, dynamic> json) => Empresa(
        id: json['id'],
        activo: json['activo'],
        nombre: json['nombre'],
        fechaCreacion: DateTime.parse(json['fechaCreacion']),
        celular: json['celular'],
        telefono: json['telefono'],
        fechaInauguracion: DateTime.parse(json['fechaInauguracion']),
        direccion: json['direccion'],
        registroContribuyente: json['registroContribuyente'],
        logo: json['logo'],
        moneda: Moneda.values.byName(json['moneda']),
        idioma: Idioma.values.byName(json['idioma']),
      );

  @override
  String toString() {
    return nombre;
  }
}
