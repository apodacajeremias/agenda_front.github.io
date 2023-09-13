import 'package:agenda_front/constants.dart';
import 'package:flutter/material.dart';

class IndexHeader extends StatelessWidget {
  final String title;
  final String? optionalText;
  const IndexHeader({super.key, required this.title, this.optionalText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              maxLines: 3,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(width: defaultPadding / 2),
          if (optionalText != null) ...[
            Text(
              optionalText!,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ]
        ],
      ),
    );
  }
}
