import 'package:flutter/material.dart';

class NoPageFoundView extends StatelessWidget {
  const NoPageFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('404 - Página no encontrada',
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.apply(color: Colors.red)),
    );
  }
}
