import 'package:flutter/material.dart';

class EButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color? color;
  final Function? onPressed;

  factory EButton.registrar({required Function onPressed}) => EButton(
      text: 'Registrar', icon: Icons.add_outlined, onPressed: onPressed);

  factory EButton.editar({required Function onPressed}) =>
      EButton(text: 'Editar', icon: Icons.edit_outlined, onPressed: onPressed);

  factory EButton.listo({required Function onPressed}) =>
      EButton(text: 'Listo', icon: Icons.done_outlined, onPressed: onPressed);

  const EButton(
      {super.key, required this.text, this.icon, this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return ElevatedButton.icon(
          onPressed: () {
            if (onPressed != null) onPressed!();
          },
          icon: Icon(icon),
          style: color != null
              ? ElevatedButton.styleFrom(backgroundColor: color)
              : null,
          label: buildMouseRegionForText());
    }
    return ElevatedButton(
        onPressed: () {
          if (onPressed != null) onPressed!();
        },
        style: color != null
            ? ElevatedButton.styleFrom(backgroundColor: color)
            : null,
        child: buildMouseRegionForText());
  }

  buildMouseRegionForText() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Text(text),
    );
  }
}
