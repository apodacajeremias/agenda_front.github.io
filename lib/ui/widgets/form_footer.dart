import 'package:agenda_front/constants.dart';
import 'package:agenda_front/ui/widgets/elevated_button.dart';
import 'package:agenda_front/ui/widgets/link_button.dart';
import 'package:flutter/material.dart';

class FormFooter extends StatelessWidget {
  final Function onConfirm;
  const FormFooter({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultSizing),
      child: Row(
        children: [
          Expanded(
              child: LinkButton.cancel(
                  onPressed: () => Navigator.of(context).pop())),
          const SizedBox(width: defaultSizing),
          Expanded(
              child: EButton.listo(
            onPressed: onConfirm,
          )),
        ],
      ),
    );
  }
}
