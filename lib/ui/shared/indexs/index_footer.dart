import 'package:flutter/material.dart';

class IndexFooter extends StatelessWidget {
  const IndexFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          height: size.height * 0.01,
        )
      ],
    );
  }
}
