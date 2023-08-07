// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomInputs {
  static InputDecoration form(
      {required String label, required String hint, required IconData icon}) {
    return InputDecoration(
      border: OutlineInputBorder(borderSide: BorderSide()),
      disabledBorder: OutlineInputBorder(borderSide: BorderSide()),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide()),
      errorBorder: OutlineInputBorder(borderSide: BorderSide()),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide()),
      labelText: label, // ARRIBA
      hintText: hint, // ADENTRO
      prefixIcon: Icon(icon),
      filled: true,
    );
  }

  static InputDecoration search({
    String? label,
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: OutlineInputBorder(borderSide: BorderSide()),
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon),
    );
  }

  static InputDecoration noBorder(
      {String? label, String? hint, IconData? icon}) {
    return InputDecoration(
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: OutlineInputBorder(borderSide: BorderSide()),
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon),
    );
  }
}
