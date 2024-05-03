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
        const _Separator(),
        const SizedBox(width: minimumSizing),
        Text(text,
            style: Theme.of(context).textTheme.labelLarge?.apply(
                color: color?.withOpacity(0.7) ??
                    Theme.of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(0.7))),
        const SizedBox(width: minimumSizing),
        const _Separator()
      ],
    );
  }
}

class _Separator extends StatelessWidget {
  const _Separator();

  @override
  Widget build(BuildContext context) {
    return const Expanded(child: Divider());
  }
}
