
class HorarioDisponible {
  DateTime inicio;
  DateTime fin;
  HorarioDisponible({
    required this.inicio,
    required this.fin,
  });

  factory HorarioDisponible.fromJson(Map<String, dynamic> json) => HorarioDisponible(
        inicio: DateTime.parse(json['inicio']),
        fin: DateTime.parse(json['fin']),
      );

  @override
  String toString() {
    return '$inicio a $fin';
  }
}
