import 'package:agenda_front/src/models/entities/beneficio.dart';
import 'package:agenda_front/src/models/enums/tipo_descuento.dart';

class Promocion {
  String id;
  bool activo;
  String nombre;
  DateTime fechaCreacion;

  DateTime inicio;
  DateTime fin;
  double valor;
  TipoDescuento? tipoDescuento;
  List<Beneficio>? beneficios;

  Promocion({
    required this.id,
    required this.activo,
    required this.nombre,
    required this.fechaCreacion,
    required this.inicio,
    required this.fin,
    required this.valor,
    this.tipoDescuento,
    this.beneficios,
  });

  factory Promocion.fromJson(Map<String, dynamic> json) => Promocion(
      id: json["id"],
      activo: json["activo"],
      nombre: json["nombre"],
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
