// ignore_for_file: constant_identifier_names
enum Situacion {
  AUSENTE,
  ATRASADO,
  CANCELADO,
  FINALIZADO,
  PENDIENTE,
  PRESENTE;

  @override
  String toString() {
    return name;
  }
}
