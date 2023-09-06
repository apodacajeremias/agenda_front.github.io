import 'package:agenda_front/constants.dart';
import 'package:flutter/material.dart';

class TextSeparator extends StatelessWidget {
  final String text;
  final Color? color;

  const TextSeparator({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _myDivider(context),
        const SizedBox(width: defaultPadding / 4),
        Text(text,
            style: Theme.of(context).textTheme.labelLarge?.apply(
                color: color?.withOpacity(0.7) ??
                    Theme.of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(0.7))),
        const SizedBox(width: defaultPadding / 4),
        _myDivider(context),
      ],
    );
  }

  Expanded _myDivider(BuildContext context) {
    return Expanded(
        child: Divider(
            color: color?.withOpacity(0.7) ??
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7)));
  }
}
