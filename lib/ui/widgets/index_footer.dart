import 'package:flutter/material.dart';

class IndexFooter extends StatelessWidget {
  const IndexFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Text(FechaUtil.formatDate(DateTime.now()))
      ],
    );
  }
}
