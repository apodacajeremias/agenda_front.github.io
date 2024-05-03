import 'package:agenda_front/constants.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final Widget? action;

  const Header({super.key, required this.title, this.action});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultSizing),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              maxLines: 3,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          if (action != null) ...[action!]
        ],
      ),
    );
  }
}
