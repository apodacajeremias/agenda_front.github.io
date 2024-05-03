import 'package:flutter/material.dart';

class OButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Function? onPressed;
  const OButton({super.key, required this.text, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return OutlinedButton.icon(
          onPressed: () {
            if (onPressed != null) onPressed!();
          },
          icon: Icon(icon),
          label: buildMouseRegionForText());
    }
    return OutlinedButton(
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
