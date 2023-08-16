// ignore_for_file: constant_identifier_names
enum Moneda {
  GUARANI,
  REAL,
  DOLAR;

  @override
  String toString() {
    return name;
  }
}

extension MonedaExtension on Moneda {}
