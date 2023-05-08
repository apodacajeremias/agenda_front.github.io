import 'package:intl/intl.dart';

class FechaUtil {
  static final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  static final DateFormat _timeFormat = DateFormat('HH:mm');

  static String formatDate(DateTime date) {
    return _dateFormat.format(date);
  }

  static DateTime parseDate(String dateString) {
    try {
      return _dateFormat.parseStrict(dateString);
    } catch (e) {
      throw FormatException('Invalid date format $dateString');
    }
  }

  static String formatTime(DateTime time) {
    return _timeFormat.format(time);
  }

  static DateTime parseTime(String timeString) {
    try {
      return _timeFormat.parseStrict(timeString);
    } catch (e) {
      throw FormatException('Invalid date format $timeString');
    }
  }
}
