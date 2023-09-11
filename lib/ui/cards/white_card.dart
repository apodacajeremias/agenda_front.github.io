import 'package:agenda_front/constants.dart';
import 'package:flutter/material.dart';

class WhiteCard extends StatelessWidget {
  /// CABECERA: puede ser nulo
  final Widget? header;

  /// Contenido: no puede ser nulo
  final Widget child;

  /// PIE: puede ser nulo
  final Widget? footer;

  /// Ancho: puede ser nulo
  final double? width;

  const WhiteCard(
      {super.key, this.header, required this.child, this.footer, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.all(defaultPadding / 2),
      padding: const EdgeInsets.all(defaultPadding / 2),
      decoration: buildBoxDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (header != null) ...[header!, const Divider()],
          child,
          if (footer != null) ...[const Divider(), footer!],
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration(BuildContext context) => BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).colorScheme.shadow.withOpacity(0.5),
                blurRadius: 5)
          ]);
}
