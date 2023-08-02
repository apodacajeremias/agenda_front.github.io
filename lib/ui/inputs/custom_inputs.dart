import 'package:flutter/material.dart';

class CustomInputs {
  static InputDecoration form(
      {required String label,
      required String hint,
      required IconData icon,
      Color color = Colors.blueGrey}) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: color.withOpacity(0.5))),
      disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color.withOpacity(0.3))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color.withOpacity(0.7))),
      errorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: color.withRed(130))),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: color)),
      labelText: label, // ARRIBA
      labelStyle: TextStyle(color: color),
      hintText: hint, // ADENTRO
      hintStyle: TextStyle(color: color.withOpacity(0.5)),
      prefixIcon: Icon(icon, color: color.withOpacity(0.5)),
      filled: true,
      fillColor: color.withOpacity(0.1),
    );
  }

  static InputDecoration search(
      {String? label,
      required String hint,
      required IconData icon,
      Color color = Colors.blueGrey}) {
    return InputDecoration(
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color.withOpacity(0.3))),
      labelText: label,
      labelStyle: TextStyle(color: color.withOpacity(0.7)),
      hintText: hint,
      hintStyle: TextStyle(color: color.withOpacity(0.5)),
      prefixIcon: Icon(icon, color: color.withOpacity(0.5)),
    );
  }

  static InputDecoration noBorder(
      {String? label,
      String? hint,
      IconData? icon,
      Color color = Colors.blueGrey}) {
    return InputDecoration(
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color.withOpacity(0.3))),
      labelText: label,
      labelStyle: TextStyle(color: color.withOpacity(0.7)),
      hintText: hint,
      hintStyle: TextStyle(color: color.withOpacity(0.5)),
      prefixIcon: Icon(icon, color: color.withOpacity(0.5)),
    );
  }
}
