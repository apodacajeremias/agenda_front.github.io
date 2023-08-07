
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final bool isFilled;
  final IconData icon;

  const CustomIconButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.isFilled = false,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        onPressed();
      },
      child: Row(
        children: [
          Icon(
            icon,
          ),
          Text(text)
        ],
      ),
    );
  }
}
