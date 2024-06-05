import 'package:flutter/material.dart';

class EButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Function? onPressed;
  const EButton({super.key, required this.text, this.icon, this.onPressed});

  factory EButton.registrar({required Function onPressed}) => EButton(
      text: 'Registrar', icon: Icons.add_outlined, onPressed: onPressed);

  factory EButton.editar({required Function onPressed}) =>
      EButton(text: 'Editar', icon: Icons.edit_outlined, onPressed: onPressed);

  factory EButton.listo({required Function onPressed}) =>
      EButton(text: 'Listo', icon: Icons.done_outlined, onPressed: onPressed);

  factory EButton.icon({required IconData icon, required Function onPressed}) =>
      EButton(text: '', icon: icon, onPressed: onPressed);

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
