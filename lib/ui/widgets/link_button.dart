import 'package:agenda_front/constants.dart';
import 'package:flutter/material.dart';

class LinkButton extends StatefulWidget {
  final String text;
  final Color? color;
  final Function? onPressed;

  const LinkButton({super.key, required this.text, this.onPressed, this.color});

  factory LinkButton.cancel({required Function onPressed}) =>
      LinkButton(text: 'No, cancelar', onPressed: onPressed);

  factory LinkButton.back({required Function onPressed}) =>
      LinkButton(text: 'Volver', onPressed: onPressed);

  @override
  State<LinkButton> createState() => _LinkButtonState();
}

class _LinkButtonState extends State<LinkButton> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (widget.onPressed != null) widget.onPressed!();
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => isHover = true),
        onExit: (_) => setState(() => isHover = false),
        child: Container(
          margin: const EdgeInsets.symmetric(
              horizontal: defaultSizing, vertical: minimumSizing),
          child: Text(widget.text,
              style: Theme.of(context).textTheme.labelLarge?.apply(
                  decoration: isHover
                      ? TextDecoration.underline
                      : TextDecoration.none)),
        ),
      ),
    );
  }
}
