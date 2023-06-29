import 'package:age_calculator/age_calculator.dart';
import 'package:intl/intl.dart';

class FechaUtil {
  static final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  static final DateFormat timeFormat = DateFormat('HH:mm');

  static String formatDate(DateTime date) {
    return dateFormat.format(date);
  }

  static DateTime parseDate(String dateString) {
    try {
      return dateFormat.parseStrict(dateString);
    } catch (e) {
      throw FormatException('Invalid date format $dateString');
    }
  }

  static String formatTime(DateTime time) {
    return timeFormat.format(time);
  }

  static DateTime parseTime(String timeString) {
    try {
      return timeFormat.parseStrict(timeString);
    } catch (e) {
      throw FormatException('Invalid date format $timeString');
    }
  }

  static int calcularEdad(DateTime fechaNacimiento) {
    return AgeCalculator.age(fechaNacimiento).years;
  }
}
