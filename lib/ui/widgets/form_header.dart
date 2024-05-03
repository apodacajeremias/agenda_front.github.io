import 'package:agenda_front/ui/widgets/header.dart';
import 'package:agenda_front/ui/widgets/link_button.dart';
import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  final String title;
  const FormHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Header(
        title: title,
        action: LinkButton.back(onPressed: () => Navigator.of(context).pop()));
  }
}
