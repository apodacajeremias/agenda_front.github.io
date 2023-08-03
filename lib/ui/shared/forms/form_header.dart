import 'package:agenda_front/ui/buttons/link_text.dart';
import 'package:agenda_front/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  final String title;
  final String? backText;
  const FormHeader({super.key, required this.title, this.backText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: CustomLabels.h1,
        ),
        LinkText(
            text: backText ?? 'Volver',
            color: Colors.blue.withOpacity(0.4),
            onPressed: () => Navigator.of(context).pop())
      ],
    );
  }
}
