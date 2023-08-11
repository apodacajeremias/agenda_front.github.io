import 'package:agenda_front/ui/inputs/custom_inputs.dart';
import 'package:currency_textfield/currency_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FormBuilderMoney extends StatelessWidget {
  final String name;
  final String label;
  final double? initialValue;
  final bool enabled;
  const FormBuilderMoney(
      {super.key,
      required this.name,
      required this.label,
      this.initialValue,
      required this.enabled});

  @override
  Widget build(BuildContext context) {
    var controller = CurrencyTextFieldController(
        initDoubleValue: initialValue, enableNegative: false);
    return FormBuilderTextField(
      name: name,
      controller: controller,
      enabled: enabled,
      decoration: CustomInputs.form(
          label: label, hint: 'Ingrese un valor', icon: Icons.tag),
      validator: FormBuilderValidators.min(1, errorText: 'Ingrese un valor'),
      valueTransformer: (value) =>
          (value != null) ? controller.doubleValue : null,
      keyboardType: TextInputType.number,
    );
  }
}
