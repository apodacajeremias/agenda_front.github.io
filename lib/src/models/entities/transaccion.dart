import 'package:agenda_front/src/models/entities/beneficio.dart';
import 'package:agenda_front/src/models/entities/grupo.dart';
import 'package:agenda_front/src/models/entities/persona.dart';
import 'package:agenda_front/src/models/entities/promocion.dart';
import 'package:agenda_front/src/models/entities/transaccion_detalle.dart';
import 'package:agenda_front/src/models/enums/tipo_beneficio.dart';
import 'package:agenda_front/src/models/enums/tipo_descuento.dart';
import 'package:agenda_front/src/models/enums/tipo_transaccion.dart';

class Transaccion {
  String id;
  bool activo;
  String nombre;
  DateTime fechaCreacion;

  TipoTransaccion tipo;
  double total;
  double descuento;
  double sumatoria;
  bool aplicarPromocion;
  TipoBeneficio? tipoBeneficio;
  TipoDescuento? tipoDescuento;
  Persona persona;
  Grupo? grupo;
  Beneficio? beneficio;
  Promocion? promocion;
  List<TransaccionDetalle>? detalles;

  Transaccion({
    required this.id,
    required this.activo,
    required this.nombre,
    required this.fechaCreacion,
    required this.tipo,
    required this.total,
    required this.descuento,
    required this.sumatoria,
    required this.aplicarPromocion,
    this.tipoBeneficio,
    this.tipoDescuento,
    required this.persona,
    this.grupo,
    this.beneficio,
    this.promocion,
    this.detalles,
  });

  factory Transaccion.fromJson(Map<String, dynamic> json) => Transaccion(
        id: json['id'],
        activo: json['activo'],
        nombre: json['nombre'],
        fechaCreacion: DateTime.parse(json['fechaCreacion']),
        tipo: TipoTransaccion.values.byName(json['tipo']),
        total: json['total'],
        descuento: json['descuento'],
        sumatoria: json['sumatoria'],
        aplicarPromocion: json['aplicarPromocion'],
        tipoBeneficio: TipoBeneficio.values.byName(json['tipoBeneficio']),
        tipoDescuento: TipoDescuento.values.byName(json['tipoDescuento']),
        persona: Persona.fromJson(json['persona']),
        grupo: Grupo.fromJson(json['grupo']),
        beneficio: Beneficio.fromJson(json['beneficio']),
        promocion: Promocion.fromJson(json['promocion']),
        detalles: (json.containsKey('detalles') && json['detalles'] != null)
            ? List.from(
                json['detalles'].map((td) => TransaccionDetalle.fromJson(td)))
            : null,
      );

  @override
  String toString() {
    return nombre;
  }
}
