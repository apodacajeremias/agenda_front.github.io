import 'package:agenda_front/constants.dart';
import 'package:agenda_front/ui/buttons/my_text_button.dart';
import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  final String title;
  final String? backText;
  const FormHeader({super.key, required this.title, this.backText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          MyTextButton(
              text: backText ?? 'Volver',
              onPressed: () => Navigator.of(context).pop())
        ],
      ),
    );
  }
}
