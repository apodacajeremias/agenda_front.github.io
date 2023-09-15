// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/constants.dart';
import 'package:agenda_front/ui/buttons/my_elevated_button.dart';
import 'package:agenda_front/ui/buttons/my_text_button.dart';
import 'package:flutter/material.dart';

class FormFooter extends StatelessWidget {
  final Function onConfirm;
  const FormFooter({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
      child: Row(
        children: [
          Expanded(
              child: MyTextButton.cancel(
                  onPressed: () => Navigator.of(context).pop())),
          SizedBox(width: defaultPadding),
          Expanded(
              child: MyElevatedButton.done(
            onPressed: onConfirm,
          )),
        ],
      ),
    );
  }
}
