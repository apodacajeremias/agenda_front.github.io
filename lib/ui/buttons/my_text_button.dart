import 'package:agenda_front/constants.dart';
import 'package:flutter/material.dart';

class MyTextButton extends StatefulWidget {
  final String text;
  final Color? color;
  final Function? onPressed;

  const MyTextButton({Key? key, required this.text, this.onPressed, this.color})
      : super(key: key);

  @override
  State<MyTextButton> createState() => _MyTextButtonState();
}

class _MyTextButtonState extends State<MyTextButton> {
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
              horizontal: defaultPadding, vertical: defaultPadding / 2),
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
