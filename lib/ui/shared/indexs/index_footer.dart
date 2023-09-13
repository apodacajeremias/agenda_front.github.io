import 'package:agenda_front/utils/fecha_util.dart';
import 'package:flutter/material.dart';

class IndexFooter extends StatelessWidget {
  const IndexFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [Text(FechaUtil.formatDate(DateTime.now()))],
    );
  }
}
