import 'package:agenda_front/constants.dart';
import 'package:flutter/material.dart';

class TextProfileDetail extends StatelessWidget {
  final IconData icon;
  final String? title;
  final String? text;

  const TextProfileDetail(
      {super.key, required this.icon, this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Icon(icon),
        const SizedBox(width: defaultPadding / 2),
        RichText(
            maxLines: 3,
            text: TextSpan(
                text: title != null ? '$title ' : null,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text: text, style: Theme.of(context).textTheme.bodyMedium)
                ]))
      ],
    );
  }
}
