import 'package:agenda_front/src/models/enums/tipo_transaccion.dart';

class Item {
  String id;
  bool activo;
  String nombre;
  DateTime fechaCreacion;

  double? precio;
  TipoTransaccion? tipo;

  Item({
    required this.id,
    required this.activo,
    required this.nombre,
    required this.fechaCreacion,
    this.precio,
    this.tipo,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json['id'],
        activo: json['activo'],
        nombre: json['nombre'],
        fechaCreacion: DateTime.parse(json['fechaCreacion']),
        precio: json['precio'],
        tipo: TipoTransaccion.values.byName(json['tipo']),
      );

  @override
  String toString() {
    return nombre;
  }
}
