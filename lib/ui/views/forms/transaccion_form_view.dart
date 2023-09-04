// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/constants.dart';
import 'package:agenda_front/models/entities/persona.dart';
import 'package:agenda_front/models/entities/transaccion.dart';
import 'package:agenda_front/models/enums/tipo_transaccion.dart';
import 'package:agenda_front/providers/persona_provider.dart';
import 'package:agenda_front/providers/transaccion_provider.dart';
import 'package:agenda_front/ui/cards/white_card.dart';
import 'package:agenda_front/ui/inputs/custom_inputs.dart';
import 'package:agenda_front/ui/shared/forms/form_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransaccionFormView extends StatefulWidget {
  final Transaccion? transaccion;
  const TransaccionFormView({super.key, this.transaccion});

  @override
  State<TransaccionFormView> createState() => _TransaccionFormViewState();
}

class _TransaccionFormViewState extends State<TransaccionFormView> {
  @override
  void initState() {
    Provider.of<PersonaProvider>(context, listen: false).buscarTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransaccionProvider>(context, listen: false);
    final personas = Provider.of<PersonaProvider>(context).personas;
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          FormHeader(title: 'Transacción'),
          WhiteCard(
              title: widget.transaccion?.id ?? 'Nueva transacción',
              child: FormBuilder(
                  key: provider.formKey,
                  child: Column(
                    children: [
                      if (widget.transaccion?.id != null) ...[
                        const SizedBox(height: defaultPadding),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: FormBuilderTextField(
                                  name: 'ID',
                                  initialValue: widget.transaccion?.id,
                                  enabled: false,
                                  decoration: CustomInputs.form(
                                      label: 'ID',
                                      hint: 'ID',
                                      icon: Icons.qr_code),
                                )),
                            const SizedBox(width: defaultPadding),
                            Expanded(
                                child: FormBuilderSwitch(
                              name: 'activo',
                              title: const Text('Estado del registro'),
                              initialValue: widget.transaccion?.activo,
                              decoration: CustomInputs.noBorder(),
                            )),
                          ],
                        )
                      ],
                      SizedBox(height: defaultPadding),
                      FormBuilderSearchableDropdown(
                        name: 'persona',
                        initialValue: widget.transaccion?.persona,
                        enabled: widget.transaccion?.activo ?? true,
                        decoration: CustomInputs.form(
                            label: 'Asociar transacción a la persona',
                            hint: 'Seleccione una persona',
                            icon: Icons.supervised_user_circle),
                        compareFn: (item1, item2) =>
                            item1.id!.contains(item2.id!),
                        items: personas,
                        validator: FormBuilderValidators.required(
                            errorText: 'Campo obligatorio'),
                      ),
                      SizedBox(height: defaultPadding),
                      FormBuilderDropdown(
                        name: 'tipo',
                        initialValue:
                            widget.transaccion?.tipo ?? TipoTransaccion.VENTA,
                        enabled: widget.transaccion?.activo ?? true,
                        decoration: CustomInputs.form(
                            label: 'Tipo de transaccion',
                            hint: 'Seleccione un tipo',
                            icon: Icons.info),
                        items: TipoTransaccion.values
                            .map((t) => DropdownMenuItem(
                                value: t,
                                child: Row(
                                  children: [
                                    Icon(t.icon),
                                    const SizedBox(width: defaultPadding / 2),
                                    Text(toBeginningOfSentenceCase(
                                        t.name.toLowerCase())!)
                                  ],
                                )))
                            .toList(),
                        validator: FormBuilderValidators.required(
                            errorText: 'Campo obligatorio'),
                      )
                    ],
                  )))
        ],
      ),
    );
  }
}
