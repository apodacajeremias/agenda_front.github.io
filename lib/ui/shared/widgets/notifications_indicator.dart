import 'package:flutter/material.dart';

class NotificationsIndicator extends StatelessWidget {
  const NotificationsIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Icon(Icons.notifications_none_outlined),
        Positioned(
          left: 2,
          child: Container(
            width: 5,
            height: 5,
            decoration: buildBoxDecoration(),
          ),
        )
      ],
    );
  }

  BoxDecoration buildBoxDecoration() =>
      BoxDecoration(borderRadius: BorderRadius.circular(100));
}
