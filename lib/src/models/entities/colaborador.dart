class Colaborador {
  String id;
  bool activo;
  String nombre;
  DateTime fechaCreacion;

  String? registroContribuyente;
  String? registroProfesional;
  String? profesion;

  Colaborador({
    required this.id,
    required this.activo,
    required this.nombre,
    required this.fechaCreacion,
    this.registroContribuyente,
    this.registroProfesional,
    this.profesion,
  });

  factory Colaborador.fromJson(Map<String, dynamic> json) => Colaborador(
        id: json['id'],
        activo: json['activo'],
        nombre: json['nombre'],
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
