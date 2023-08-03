// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/ui/buttons/custom_icon_button.dart';
import 'package:flutter/material.dart';

class FormFooter extends StatelessWidget {
  final Function onConfirm;
  const FormFooter({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: CustomIconButton(
              onPressed: onConfirm, text: 'Listo', icon: Icons.done),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: CustomIconButton(
              onPressed: () => Navigator.of(context).pop(),
              text: 'Cancelar',
              icon: Icons.cancel),
        ),
      ],
    );
  }
}
