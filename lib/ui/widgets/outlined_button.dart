import 'package:agenda_front/providers.dart';
import 'package:agenda_front/services.dart';
import 'package:flutter/material.dart';

class OButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Function? onPressed;
  const OButton({super.key, required this.text, this.icon, this.onPressed});

  factory OButton.salir(AuthProvider provider) => OButton(
      text: 'Salir',
      icon: Icons.logout_outlined,
      onPressed: () async {
        await provider.logout();
        NavigationService.replaceTo(RouterService.rootRoute);
      });

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
