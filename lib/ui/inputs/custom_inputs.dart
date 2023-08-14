// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomInputs {
  static InputDecoration form(
      {required String label, required String hint, required IconData icon}) {
    return InputDecoration(
        labelText: label, // ARRIBA
        hintText: hint, // ADENTRO
        prefixIcon: Icon(icon));
  }

  static InputDecoration noBorder() {
    return InputDecoration(border: InputBorder.none);
  }
}
