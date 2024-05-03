import 'package:agenda_front/constants.dart';
import 'package:flutter/material.dart';

class WhiteCard extends StatelessWidget {
  /// Titulo: puede ser nulo
  final String? title;

  /// Accion: puede ser nulo
  final Widget? actions;

  /// Contenido: no puede ser nulo
  final Widget child;

  /// PIE: puede ser nulo
  final Widget? footer;

  /// Ancho: puede ser nulo
  final double? width;

  const WhiteCard(
      {super.key,
      this.title,
      this.actions,
      this.footer,
      this.width,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.all(minimumSizing),
      padding: const EdgeInsets.all(minimumSizing),
      decoration: buildBoxDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null || actions != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (title != null)
                  Text(title!,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.titleLarge),
                if (actions != null) actions!,
              ],
            ),
            const Divider(),
          ],
          child,
          if (footer != null) ...[
            const Divider(),
            Row(children: [Expanded(child: footer!)])
          ],
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
