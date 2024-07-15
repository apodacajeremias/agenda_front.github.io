import 'package:agenda_front/src/models/entities/item.dart';

class TransaccionDetalle {
  String id;
  bool? estado;
  String nombre;
  String? observacion;
  DateTime fechaCreacion;

  final double? cantidad;
  final double? valor;
  final double? subtotal;
  final Item? item;

  TransaccionDetalle({
    required this.id,
    this.estado,
    required this.nombre,
    this.observacion,
    required this.fechaCreacion,
    this.cantidad,
    this.valor,
    this.subtotal,
    this.item,
  });

  factory TransaccionDetalle.fromJson(Map<String, dynamic> json) =>
      TransaccionDetalle(
        id: json['id'],
        estado: json['estado'],
        nombre: json['nombre'],
        observacion: json['observacion'],
        fechaCreacion: DateTime.parse(json['fechaCreacion']),
        cantidad: json['cantidad'],
        valor: json['valor'],
        subtotal: json['subtotal'],
        item: (json.containsKey('item') && json['item'] != null)
            ? Item.fromJson(json['item'])
            : null,
      );

  @override
  String toString() {
    return id;
  }
}
