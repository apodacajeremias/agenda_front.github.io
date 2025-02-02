import 'package:agenda_front/enums.dart';
import 'package:agenda_front/src/models/entities/movimiento_detalle.dart';
import 'package:agenda_front/src/models/entities/persona.dart';

class Movimiento {
  String id;
  bool? estado;
  String nombre;
  String? observacion;
  DateTime fechaCreacion;

  double total;
  String? numeroComprobante;
  Moneda moneda;
  TipoMovimiento tipo;
  MedioPago medioPago;
  Persona persona;
  List<MovimientoDetalle>? detalles;

  Movimiento({
    required this.id,
    this.estado,
    required this.nombre,
    this.observacion,
    required this.fechaCreacion,
    required this.total,
    this.numeroComprobante,
    required this.moneda,
    required this.tipo,
    required this.medioPago,
    required this.persona,
    this.detalles,
  });

  factory Movimiento.fromJson(Map<String, dynamic> json) => Movimiento(
        id: json['id'],
        estado: json['estado'],
        nombre: json['nombre'],
        observacion: json['observacion'],
        fechaCreacion: DateTime.parse(json['fechaCreacion']),
        total: json['total'],
        numeroComprobante: json['numeroComprobante'],
        moneda: Moneda.values.byName(json['moneda']),
        tipo: TipoMovimiento.values.byName(json['tipo']),
        medioPago: MedioPago.values.byName(json['medioPago']),
        persona: Persona.fromJson(json['persona']),
        detalles: (json.containsKey('detalles') && json['detalles'] != null)
            ? List.from(
                json['detalles'].map((td) => MovimientoDetalle.fromJson(td)))
            : null,
      );

  @override
  String toString() {
    return nombre;
  }
}
