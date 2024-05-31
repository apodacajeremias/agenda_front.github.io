import 'package:agenda_front/enums.dart';
import 'package:agenda_front/src/models/entities/movimiento_detalle.dart';
import 'package:agenda_front/src/models/entities/persona.dart';

class Movimiento {
  String id;
  bool activo;
  String nombre;
  DateTime fechaCreacion;

  double valor;
  String? numeroComprobante;
  Moneda moneda;
  TipoMovimiento tipo;
  MedioPago medioPago;
  Persona persona;
  List<MovimientoDetalle>? detalles;

  Movimiento({
    required this.id,
    required this.activo,
    required this.nombre,
    required this.fechaCreacion,
    required this.valor,
    this.numeroComprobante,
    required this.moneda,
    required this.tipo,
    required this.medioPago,
    required this.persona,
    this.detalles,
  });

  factory Movimiento.fromJson(Map<String, dynamic> json) => Movimiento(
        id: json['id'],
        activo: json['activo'],
        nombre: json['nombre'],
        fechaCreacion: DateTime.parse(json['fechaCreacion']),
        valor: json['valor'],
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
