import 'package:agenda_front/ui/buttons/my_text_button.dart';
import 'package:agenda_front/ui/shared/my_header.dart';
import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  final String title;
  const FormHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return MyHeader(
        title: title,
        action:
            MyTextButton.back(onPressed: () => Navigator.of(context).pop()));
  }
}
