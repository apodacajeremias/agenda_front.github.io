import 'package:agenda_front/constants.dart';
import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  final String title;
  final String asset;
  const MyTitle({super.key, required this.title, required this.asset});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: AssetImage(asset),
            width: 50,
            height: 50,
          ),
          const SizedBox(height: defaultPadding),
          FittedBox(
            fit: BoxFit.contain,
            child: Text(title, style: Theme.of(context).textTheme.displaySmall),
          )
        ],
      ),
    );
  }
}
