import 'package:flutter/material.dart';

//TODO: generar extension
class CustomInputs {
  static InputDecoration form(
      {required String label, required String hint, required IconData icon}) {
    return InputDecoration(
        labelText: label, // ARRIBA
        hintText: hint, // ADENTRO
        prefixIcon: Icon(icon));
  }

  static InputDecoration noBorder(
      {String label = '', String hint = '', IconData? icon}) {
    return InputDecoration(
        labelText: label, // ARRIBA
        hintText: hint, // ADENTRO
        prefixIcon: Icon(icon),
        border: InputBorder.none);
  }
}
