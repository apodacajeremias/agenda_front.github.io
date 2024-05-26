import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension BuildContextExtensionMediaQuery on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width <= 500.0;

  bool get isTablet =>
      MediaQuery.of(this).size.width < 1024.0 &&
      MediaQuery.of(this).size.width >= 650.0;

  bool get isSmallTablet =>
      MediaQuery.of(this).size.width < 650.0 &&
      MediaQuery.of(this).size.width > 500.0;

  bool get isDesktop => MediaQuery.of(this).size.width >= 1024.0;

  bool get isSmall =>
      MediaQuery.of(this).size.width < 850.0 &&
      MediaQuery.of(this).size.width >= 560.0;

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  Size get size => MediaQuery.of(this).size;
}

extension BuildContextExtensionTextTheme on BuildContext {
  // text styles

  TextStyle? get displayMedium => Theme.of(this).textTheme.displayMedium;

  TextStyle? get displaySmall => Theme.of(this).textTheme.displaySmall;

  TextStyle? get headlineLarge => Theme.of(this).textTheme.headlineLarge;

  TextStyle? get headlineMedium => Theme.of(this).textTheme.headlineMedium;

  TextStyle? get titleLarge => Theme.of(this).textTheme.titleLarge;

  TextStyle? get titleMedium => Theme.of(this).textTheme.titleMedium;

  TextStyle? get titleSmall => Theme.of(this).textTheme.titleSmall;

  TextStyle? get labelLarge => Theme.of(this).textTheme.labelLarge;

  TextStyle? get bodySmall => Theme.of(this).textTheme.bodySmall;

  TextStyle? get titleTextStyle => Theme.of(this).appBarTheme.titleTextStyle;

  TextStyle? get bodyExtraSmall =>
      bodySmall?.copyWith(fontSize: 10, height: 1.6, letterSpacing: .5);

  TextStyle? get bodyLarge => Theme.of(this).textTheme.bodyLarge;

  TextStyle? get dividerTextSmall => bodySmall?.copyWith(
      letterSpacing: 0.5, fontWeight: FontWeight.w700, fontSize: 12.0);

  TextStyle? get dividerTextLarge => bodySmall?.copyWith(
      letterSpacing: 1.5,
      fontWeight: FontWeight.w700,
      fontSize: 13.0,
      height: 1.23);
}

extension BuildContextExtensionColorTheme on BuildContext {
  // colors
  Color get primaryColor => Theme.of(this).primaryColor;

  Color get primaryColorDark => Theme.of(this).primaryColorDark;

  Color get primaryColorLight => Theme.of(this).primaryColorLight;

  Color get primary => Theme.of(this).colorScheme.primary;

  Color get onPrimary => Theme.of(this).colorScheme.onPrimary;

  Color get secondary => Theme.of(this).colorScheme.secondary;

  Color get onSecondary => Theme.of(this).colorScheme.onSecondary;

  Color get cardColor => Theme.of(this).cardColor;

  Color get errorColor => Theme.of(this).colorScheme.error;

  Color get background => Theme.of(this).colorScheme.background;
}

extension BuildContextExtensionSpacing on BuildContext {
  double get defaultSpace => 8;
  double get minimunSpace => defaultSpace / 2;
  double get mediumSpace => defaultSpace * 2;
  double get maximunSpace => defaultSpace * 4;
}

// TODO: transferir FechaUtil a esta extension
extension DateTimeExtensionFormat on DateTime {
  static final DateFormat _dateFormat = DateFormat('dd/MM/yy');
  static final DateFormat _timeFormat = DateFormat('HH:mm');

  String formatDate() {
    return _dateFormat.format(this);
  }

  String formatTime() {
    return _timeFormat.format(this);
  }

  String formatDateTime() {
    return '${_dateFormat.format(this)} ${_timeFormat.format(this)}';
  }

// TODO: crear function
  int edad() {
    // return AgeCalculator.age(fechaNacimiento).years;
    return 99999;
  }
}

extension StringExtension on String {
  static final DateFormat _dateFormat = DateFormat('dd/MM/yy');
  static final DateFormat _timeFormat = DateFormat('HH:mm');

  bool toBoolean() {
    return (toLowerCase() == "true" || toLowerCase() == "1")
        ? true
        : (toLowerCase() == "false" || toLowerCase() == "0"
            ? false
            : throw UnsupportedError(
                'Cannot convert ${toLowerCase()} to bool value.'));
  }

  DateTime parseDate() {
    try {
      return _dateFormat.parseStrict(this);
    } catch (e) {
      throw FormatException('Invalid date format $this');
    }
  }

  DateTime parseTime() {
    try {
      return _timeFormat.parseStrict(this);
    } catch (e) {
      throw FormatException('Invalid date format $this');
    }
  }

  String firstWord() {
    return split(RegExp(r'(\s+)')).first;
  }
}
