import 'package:agenda_front/providers.dart';
import 'package:agenda_front/src/models/entities/item.dart';
import 'package:agenda_front/translate.dart';
import 'package:agenda_front/ui/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class ItemSearchableDropdown extends StatefulWidget {
  final String name;
  final Item? unique;
  final Function(Item?)? onChanged;

  const ItemSearchableDropdown(
      {super.key, required this.name, this.unique, this.onChanged});

  @override
  State<ItemSearchableDropdown> createState() => _ItemSearchableDropdownState();
}

class _ItemSearchableDropdownState extends State<ItemSearchableDropdown> {
  @override
  void initState() {
    widget.unique ??
        Provider.of<ItemProvider>(context, listen: false).buscarTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.unique != null
        ? [widget.unique!]
        : Provider.of<ItemProvider>(context).items;
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
          hint: AppLocalizations.of(context)!.item(''),
          label: AppLocalizations.of(context)!.item('asignar'),
          icon: Icons.person_outline),
    );
  }
}
