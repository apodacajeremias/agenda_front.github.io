class Colaborador {
  String id;
  bool? estado;
  String nombre;
  String? observacion;
  DateTime fechaCreacion;

  String? registroContribuyente;
  String? registroProfesional;
  String? profesion;

  Colaborador({
    required this.id,
    this.estado,
    required this.nombre,
    this.observacion,
    required this.fechaCreacion,
    this.registroContribuyente,
    this.registroProfesional,
    this.profesion,
  });

  factory Colaborador.fromJson(Map<String, dynamic> json) => Colaborador(
        id: json['id'],
        estado: json['estado'],
        nombre: json['nombre'],
        observacion: json['observacion'],
        fechaCreacion: DateTime.parse(json['fechaCreacion']),
        registroContribuyente: json['registroContribuyente'],
        registroProfesional: json['registroProfesional'],
        profesion: json['profesion'],
      );

  @override
  String toString() {
    return nombre;
  }
}
