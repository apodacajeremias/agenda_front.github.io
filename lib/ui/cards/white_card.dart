import 'package:agenda_front/constants.dart';
import 'package:flutter/material.dart';

class WhiteCard extends StatelessWidget {
  /// Titulo: puede ser nulo
  final String? title;

  /// Contenido: no puede ser nulo
  final Widget child;

  /// Ancho: puede ser nulo
  final double? width;

  const WhiteCard({super.key, this.title, this.width, required this.child});

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
          if (title != null) ...[
            FittedBox(
              fit: BoxFit.contain,
              child: Text(
                title!,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Divider()
          ],
          child
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
