import 'package:agenda_front/src/models/entities/beneficio.dart';
import 'package:agenda_front/src/models/entities/grupo.dart';
import 'package:agenda_front/src/models/entities/persona.dart';
import 'package:agenda_front/src/models/entities/promocion.dart';
import 'package:agenda_front/src/models/entities/transaccion_detalle.dart';
import 'package:agenda_front/src/models/enums/tipo_transaccion.dart';

class Transaccion {
  String id;
  bool? estado;
  String nombre;
  String? observacion;
  DateTime fechaCreacion;

  TipoTransaccion tipo;
  double total;
  double descuento;
  double sumatoria;
  bool aplicarDescuento;
  Persona persona;
  Grupo? grupo;
  Beneficio? beneficio;
  Promocion? promocion;
  List<TransaccionDetalle>? detalles;

  Transaccion({
    required this.id,
    this.estado,
    required this.nombre,
    this.observacion,
    required this.fechaCreacion,
    required this.tipo,
    required this.total,
    required this.descuento,
    required this.sumatoria,
    required this.aplicarDescuento,
    required this.persona,
    this.grupo,
    this.beneficio,
    this.promocion,
    this.detalles,
  });

  factory Transaccion.fromJson(Map<String, dynamic> json) => Transaccion(
        id: json['id'],
        estado: json['estado'],
        nombre: json['nombre'],
        observacion: json['observacion'],
        fechaCreacion: DateTime.parse(json['fechaCreacion']),
        tipo: TipoTransaccion.values.byName(json['tipo']),
        total: json['total'],
        descuento: json['descuento'],
        sumatoria: json['sumatoria'],
        aplicarDescuento: json['aplicarDescuento'],
        persona: Persona.fromJson(json['persona']),
        grupo: (json.containsKey('grupo') && json['grupo'] != null)
            ? Grupo.fromJson(json['grupo'])
            : null,
        beneficio: (json.containsKey('beneficio') && json['beneficio'] != null)
            ? Beneficio.fromJson(json['beneficio'])
            : null,
        promocion: (json.containsKey('promocion') && json['promocion'] != null)
            ? Promocion.fromJson(json['promocion'])
            : null,
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
