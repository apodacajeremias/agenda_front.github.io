// ignore_for_file: constant_identifier_names

enum MedioPago {
  EFECTIVO,
  TARJETA_DEBITO,
  TARJETA_CREDITO,
  CHEQUE,
  TRANSFERENCIA_BANCARIA,
  BILLETERA_ELECTRONICA;

  @override
  String toString() {
    return name;
  }
}
