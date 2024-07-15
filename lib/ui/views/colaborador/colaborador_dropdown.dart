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
  final bool? agendable;
  final Colaborador? unique;
  final Function(Colaborador?)? onChanged;

  const ColaboradorSearchableDropdown(
      {super.key,
      required this.name,
      this.unique,
      this.onChanged,
      this.agendable});

  @override
  State<ColaboradorSearchableDropdown> createState() =>
      _ColaboradorSearchableDropdownState();
}

class _ColaboradorSearchableDropdownState
    extends State<ColaboradorSearchableDropdown> {
  @override
  void initState() {
    widget.unique ??
        Provider.of<ColaboradorProvider>(context, listen: false).buscarTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.unique != null
        ? [widget.unique!]
        : Provider.of<ColaboradorProvider>(context).colaboradores;
    return FormBuilderSearchableDropdown(
      name: widget.name,
      initialValue: widget.unique,
      items: items,
      compareFn: (item1, item2) => item1.id.contains(item2.id),
      onChanged: widget.onChanged,
      validator: FormBuilderValidators.required(errorText: 'Campo obligatorio'),
      valueTransformer: (value) => value?.id,
      decoration: CustomInputs.form(
          hint: '${toBeginningOfSentenceCase(widget.name)}',
          label: '${toBeginningOfSentenceCase(widget.name)}',
          icon: Icons.person_outline),
    );
  }
}
