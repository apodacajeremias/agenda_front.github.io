import 'package:agenda_front/ui/inputs/custom_inputs.dart';
import 'package:currency_textfield/currency_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TextCurrency extends StatelessWidget {
  final double initialValue;
  const TextCurrency(this.initialValue, {super.key});

  @override
  Widget build(BuildContext context) {
    var controller = CurrencyTextFieldController(
        initDoubleValue: initialValue, enableNegative: false);
    return FormBuilderTextField(
      name: 'text-currency',
      controller: controller,
      readOnly: true,
      decoration: CustomInputs.noBorder(),
    );
  }
}
