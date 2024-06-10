import 'package:agenda_front/src/models/entities/promocion.dart';
import 'package:agenda_front/src/models/enums/tipo_beneficio.dart';
import 'package:agenda_front/src/models/enums/tipo_descuento.dart';

class Beneficio {
  String id;
  bool? activo;
  String nombre;
  String? observacion;
  DateTime fechaCreacion;

  TipoBeneficio? tipo;
  TipoDescuento? tipoDescuento;
  double? descuento;
  List<Promocion>? promociones;

  Beneficio({
    required this.id,
    this.activo,
    required this.nombre,
    this.observacion,
    required this.fechaCreacion,
    this.tipo,
    this.tipoDescuento,
    this.descuento,
    this.promociones,
  });

  factory Beneficio.fromJson(Map<String, dynamic> json) => Beneficio(
        id: json['id'],
        activo: json['activo'],
        nombre: json['nombre'],
        observacion: json['observacion'],
        fechaCreacion: DateTime.parse(json['fechaCreacion']),
        tipo: TipoBeneficio.values.byName(json['tipo']),
        tipoDescuento: TipoDescuento.values.byName(json['tipoDescuento']),
        descuento: json['descuento'],
        promociones: json.containsKey('promociones') &&
                json['promociones'] != null
            ? List<Promocion>.from(
                json['promociones'].map((model) => Promocion.fromJson(model)))
            : null,
      );

  @override
  String toString() {
    return nombre;
  }
}
