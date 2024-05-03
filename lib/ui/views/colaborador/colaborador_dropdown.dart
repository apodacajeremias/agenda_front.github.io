import 'package:agenda_front/providers.dart';
import 'package:agenda_front/src/models/entities/colaborador.dart';
import 'package:agenda_front/ui/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ColaboradorSearchableDropdown extends StatefulWidget {
  final String name;
  final Colaborador? onlyValue;

  const ColaboradorSearchableDropdown(
      {super.key, required this.name, this.onlyValue});

  @override
  State<ColaboradorSearchableDropdown> createState() =>
      _ColaboradorSearchableDropdownState();
}

class _ColaboradorSearchableDropdownState
    extends State<ColaboradorSearchableDropdown> {
  @override
  void initState() {
    widget.onlyValue ??
        Provider.of<ColaboradorProvider>(context, listen: false).buscarTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.onlyValue != null
        ? [widget.onlyValue!]
        : Provider.of<ColaboradorProvider>(context).colaboradores;
    return FormBuilderSearchableDropdown(
      name: widget.name,
      initialValue: widget.onlyValue,
      items: items,
      compareFn: (item1, item2) => item1.id!.contains(item2.id!),
      validator: FormBuilderValidators.required(errorText: 'Campo obligatorio'),
      valueTransformer: (value) => value?.id,
      decoration: CustomInputs.form(
          hint: '${toBeginningOfSentenceCase(widget.name)}',
          label: '${toBeginningOfSentenceCase(widget.name)}',
          icon: Icons.person_outline),
    );
  }
}
