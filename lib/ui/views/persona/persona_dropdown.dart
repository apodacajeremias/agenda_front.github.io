import 'package:agenda_front/providers.dart';
import 'package:agenda_front/src/models/entities/persona.dart';
import 'package:agenda_front/ui/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PersonaSearchableDropdown extends StatefulWidget {
  final String name;
  final Persona? onlyValue;

  const PersonaSearchableDropdown(
      {super.key, required this.name, this.onlyValue});

  @override
  State<PersonaSearchableDropdown> createState() =>
      _PersonaSearchableDropdownState();
}

class _PersonaSearchableDropdownState extends State<PersonaSearchableDropdown> {
  @override
  void initState() {
    widget.onlyValue ??
        Provider.of<PersonaProvider>(context, listen: false).buscarTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.onlyValue != null
        ? [widget.onlyValue!]
        : Provider.of<PersonaProvider>(context).personas;
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
