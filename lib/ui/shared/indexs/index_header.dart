import 'package:agenda_front/ui/shared/my_header.dart';
import 'package:flutter/material.dart';

class IndexHeader extends StatelessWidget {
  final String title;
  const IndexHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return MyHeader(title: title);
  }
}
