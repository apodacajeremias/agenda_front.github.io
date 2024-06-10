import 'package:agenda_front/src/models/entities/beneficio.dart';
import 'package:agenda_front/src/models/enums/tipo_descuento.dart';

class Promocion {
  String id;
  bool? estado;
  String nombre;
  String? observacion;
  DateTime fechaCreacion;

  DateTime inicio;
  DateTime fin;
  double valor;
  TipoDescuento? tipoDescuento;
  List<Beneficio>? beneficios;

  Promocion({
    required this.id,
    this.estado,
    required this.nombre,
    this.observacion,
    required this.fechaCreacion,
    required this.inicio,
    required this.fin,
    required this.valor,
    this.tipoDescuento,
    this.beneficios,
  });

  factory Promocion.fromJson(Map<String, dynamic> json) => Promocion(
      id: json["id"],
      estado: json["estado"],
      nombre: json["nombre"],
      observacion: json['observacion'],
      fechaCreacion: DateTime.parse(json['fechaCreacion']),
      inicio: DateTime.parse(json['inicio']),
      fin: DateTime.parse(json['fin']),
      valor: json["valor"],
      tipoDescuento: TipoDescuento.values.byName(json['tipoDescuento']),
      beneficios: json['beneficios']);

  @override
  String toString() {
    return nombre;
  }
}
