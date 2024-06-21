// ignore_for_file: constant_identifier_names

enum Duracion {
  quince_minutos(15),
  treinta_minutos(30),
  una_hora(60);

  // Duracion en minutos
  final int duracion;
  const Duracion(this.duracion);

  @override
  String toString() {
    switch (this) {
      case quince_minutos:
        return '15 minutos';
      case treinta_minutos:
        return '30 minutos';
      case una_hora:
        return '1 hora';
      default:
        return '';
    }
  }
}
