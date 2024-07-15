class AgendaDetalle {
  String id;
  bool? estado;
  String nombre;
  String? observacion;
  DateTime fechaCreacion;

  AgendaDetalle({
    required this.id,
    this.estado,
    required this.nombre,
    this.observacion,
    required this.fechaCreacion,
  });

  factory AgendaDetalle.fromJson(Map<String, dynamic> json) => AgendaDetalle(
        id: json['id'],
        estado: json['estado'],
        nombre: json['nombre'],
        observacion: json['observacion'],
        fechaCreacion: DateTime.parse(json['fechaCreacion']),
      );

  @override
  String toString() {
    return id;
  }
}
