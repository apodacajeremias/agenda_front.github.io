import 'package:flutter/material.dart';

class IndexHeader extends StatelessWidget {
  final String title;
  final String? optionalText;
  const IndexHeader({super.key, required this.title, this.optionalText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        if (optionalText != null) ...[
          Text(
            optionalText!,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ]
      ],
    );
  }
}
