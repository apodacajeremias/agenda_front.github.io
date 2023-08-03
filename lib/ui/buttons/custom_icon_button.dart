import 'package:agenda_front/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color color;
  final bool isFilled;
  final IconData icon;

  const CustomIconButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.color = Colors.blueGrey,
      this.isFilled = false,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        onPressed();
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const StadiumBorder()),
        backgroundColor: MaterialStateProperty.all(color.withOpacity(0.6)),
        overlayColor: MaterialStateProperty.all(color.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.black,
          ),
          Text(
            text,
            style: CustomLabels.h4.apply(color: Colors.black),
          )
        ],
      ),
    );
  }
}
