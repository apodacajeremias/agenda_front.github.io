import 'package:flutter/material.dart';

class EButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Function? onPressed;
  const EButton({super.key, required this.text, this.icon, this.onPressed});

  factory EButton.create({required Function onPressed}) =>
      EButton(text: 'Crear', icon: Icons.add_outlined, onPressed: onPressed);

  factory EButton.edit({required Function onPressed}) =>
      EButton(text: 'Editar', icon: Icons.edit_outlined, onPressed: onPressed);

  factory EButton.done({required Function onPressed}) =>
      EButton(text: 'Listo', icon: Icons.done_outlined, onPressed: onPressed);

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return ElevatedButton.icon(
          onPressed: () {
            if (onPressed != null) onPressed!();
          },
          icon: Icon(icon),
          label: buildMouseRegionForText());
    }
    return ElevatedButton(
        onPressed: () {
          if (onPressed != null) onPressed!();
        },
        child: buildMouseRegionForText());
  }

  buildMouseRegionForText() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Text(text),
    );
  }
}
