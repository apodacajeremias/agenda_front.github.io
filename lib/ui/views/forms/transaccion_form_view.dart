// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/models/entities/transaccion.dart';
import 'package:agenda_front/providers/persona_provider.dart';
import 'package:agenda_front/providers/transaccion_provider.dart';
import 'package:agenda_front/ui/cards/white_card.dart';
import 'package:agenda_front/ui/inputs/custom_inputs.dart';
import 'package:agenda_front/ui/shared/forms/form_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          FormHeader(title: 'Transacción'),
          WhiteCard(
              child: FormBuilder(
                  key: provider.formKey,
                  child: Column(
                    children: [
                      if (widget.transaccion?.id != null) ...[
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: FormBuilderTextField(
                                  name: 'id',
                                  initialValue: widget.transaccion?.id,
                                  enabled: false,
                                  decoration: CustomInputs.form(
                                      label: 'ID',
                                      hint: 'ID',
                                      icon: Icons.qr_code),
                                )),
                            SizedBox(width: 10),
                            Expanded(
                                child: FormBuilderSwitch(
                                    name: 'activo',
                                    title: Text('Estado del registro'),
                                    initialValue: widget.transaccion?.activo)),
                          ],
                        ),
                      ],
                      SizedBox(height: 10),
                      FormBuilderSearchableDropdown(
                        name: 'persona.id',
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
                        valueTransformer: (value) => value?.id,
                      )
                    ],
                  )))
        ],
      ),
    );
  }
}
