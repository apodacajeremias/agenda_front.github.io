class Colaborador {
  String id;
  bool? estado;
  String nombre;
  String? observacion;
  DateTime fechaCreacion;

  String? registroContribuyente;
  String? registroProfesional;
  String? cargo;

  Colaborador({
    required this.id,
    this.estado,
    required this.nombre,
    this.observacion,
    required this.fechaCreacion,
    this.registroContribuyente,
    this.registroProfesional,
    this.cargo,
  });

  factory Colaborador.fromJson(Map<String, dynamic> json) => Colaborador(
        id: json['id'],
        estado: json['estado'],
        nombre: json['nombre'],
        observacion: json['observacion'],
        fechaCreacion: DateTime.parse(json['fechaCreacion']),
        registroContribuyente: json['registroContribuyente'],
        registroProfesional: json['registroProfesional'],
        cargo: json['cargo'],
      );

  @override
  String toString() {
    return nombre;
  }
}
