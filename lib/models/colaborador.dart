class Colaborador {
    Colaborador({
        this.activo,
        this.fechaCreacion,
        this.fechaModificacion,
        this.registroContribuyente,
        this.registroProfesional,
        this.profesion,
        this.id,
    });

    bool? activo;
    DateTime? fechaCreacion;
    String? fechaModificacion;
    String? registroContribuyente;
    String? registroProfesional;
    String? profesion;
    String? id;

    factory Colaborador.fromJson(Map<String, dynamic> json) => Colaborador(
        activo: json["activo"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        fechaModificacion: json["fechaModificacion"],
        registroContribuyente: json["registroContribuyente"],
        registroProfesional: json["registroProfesional"],
        profesion: json["profesion"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "activo": activo,
        "fechaCreacion": fechaCreacion?.toIso8601String(),
        "fechaModificacion": fechaModificacion,
        "registroContribuyente": registroContribuyente,
        "registroProfesional": registroProfesional,
        "profesion": profesion,
        "id": id,
    };
}

