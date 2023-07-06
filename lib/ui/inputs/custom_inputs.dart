import 'package:flutter/material.dart';

class CustomInputs {
  static InputDecoration loginInputDecoration(
      {required String hint,
      required String label,
      required IconData icon,
      Color? color}) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderSide:
              BorderSide(color: color ?? Colors.white.withOpacity(0.3))),
      enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: color ?? Colors.white.withOpacity(0.3))),
      hintText: hint,
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.grey),
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey),
    );
  }

  static InputDecoration searchInputDecoration(
      {required String hint, required IconData icon}) {
    return InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.grey),
        labelStyle: const TextStyle(color: Colors.grey),
        hintStyle: const TextStyle(color: Colors.grey));
  }

  static InputDecoration iphone(
      {required String label,
      String? hint = 'Escriba aqui',
      required IconData icon}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(
        icon,
        color: Colors.grey[400],
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey[300]!,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blue,
        ),
      ),
      labelStyle: TextStyle(
        color: Colors.grey[400],
        fontSize: 16.0,
      ),
      hintStyle: TextStyle(
        color: Colors.grey[400],
        fontSize: 16.0,
      ),
      filled: true,
      fillColor: Colors.grey[100],
    );
  }

  static InputDecoration noBorder() {
    return const InputDecoration(
        border: InputBorder.none, focusedBorder: InputBorder.none);
  }

  static InputDecoration windows11(
      {required String label,
      String? hint = 'Escriba aqui',
      required IconData icon}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(
        icon,
        color: Colors.grey[600],
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey[400]!,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.blue,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      labelStyle: TextStyle(
        color: Colors.grey[600],
        fontSize: 16.0,
      ),
      hintStyle: TextStyle(
        color: Colors.grey[400],
        fontSize: 16.0,
      ),
      filled: true,
      fillColor: Colors.grey[200],
    );
  }
}
