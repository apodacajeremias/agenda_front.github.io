import 'package:agenda_front/providers.dart';
import 'package:agenda_front/src/models/entities/persona.dart';
import 'package:agenda_front/translate.dart';
import 'package:agenda_front/ui/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class PersonaSearchableDropdown extends StatefulWidget {
  final String name;
  final Persona? unique;
  final Function(Persona?)? onChanged;

  const PersonaSearchableDropdown(
      {super.key, required this.name, this.unique, this.onChanged});

  @override
  State<PersonaSearchableDropdown> createState() =>
      _PersonaSearchableDropdownState();
}

class _PersonaSearchableDropdownState extends State<PersonaSearchableDropdown> {
  @override
  void initState() {
    widget.unique ??
        Provider.of<PersonaProvider>(context, listen: false).buscarTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.unique != null
        ? [widget.unique!]
        : Provider.of<PersonaProvider>(context).personas;
    return FormBuilderSearchableDropdown(
      name: widget.name,
      initialValue: widget.unique,
      items: items,
      compareFn: (item1, item2) => item1.id.contains(item2.id),
      onChanged: widget.onChanged,
      validator: FormBuilderValidators.required(
          errorText: AppLocalizations.of(context)!.campoObligatorio),
      valueTransformer: (value) => value?.id,
      decoration: CustomInputs.form(
          hint: AppLocalizations.of(context)!.persona(''),
          label: AppLocalizations.of(context)!.persona('asignar'),
          icon: Icons.person_outline),
    );
  }
}
