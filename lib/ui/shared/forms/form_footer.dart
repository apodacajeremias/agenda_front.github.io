// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/constants.dart';
import 'package:agenda_front/ui/buttons/my_elevated_button.dart';
import 'package:agenda_front/ui/buttons/my_outlined_button.dart';
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
              child: MyElevatedButton(
            text: 'Continuar',
            icon: Icons.save,
            onPressed: onConfirm,
          )),
          SizedBox(width: defaultPadding),
          Expanded(
              child: MyOutlinedButton(
                  text: 'Cancelar',
                  onPressed: () => Navigator.of(context).pop())),
        ],
      ),
    );
  }
}
