import 'package:agenda_front/constants.dart';
import 'package:flutter/material.dart';

class TextProfileDetail extends StatelessWidget {
  final IconData icon;
  final String? title;
  final String? text;
  final bool hasDivider;

  const TextProfileDetail(
      {super.key,
      this.icon = Icons.info_outline,
      this.title,
      required this.text,
      this.hasDivider = true});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        const SizedBox(height: minimumSizing),
        if (title != null) ...[
          Row(
            children: [
              Icon(icon),
              const SizedBox(width: minimumSizing),
              Text(title!,
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold))
            ],
          ),
          const SizedBox(width: minimumSizing),
          Row(
            children: [
              Icon(icon, color: Colors.transparent),
              const SizedBox(width: minimumSizing),
              Text(text ?? '-',
                  maxLines: 5,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.w300)),
            ],
          ),
        ],
        if (title == null) ...[
          Row(
            children: [
              Icon(icon),
              const SizedBox(width: minimumSizing),
              Text(text ?? '-',
                  maxLines: 5,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.w300)),
            ],
          ),
        ],
        const SizedBox(height: minimumSizing),
        if (hasDivider) ...[
          const Divider(),
        ]
      ],
    );
  }
}
