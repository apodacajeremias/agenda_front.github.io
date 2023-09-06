// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/constants.dart';
import 'package:agenda_front/models/entities/beneficio.dart';
import 'package:agenda_front/models/entities/grupo.dart';
import 'package:agenda_front/models/entities/persona.dart';
import 'package:agenda_front/models/entities/transaccion.dart';
import 'package:agenda_front/models/enums/tipo_beneficio.dart';
import 'package:agenda_front/models/enums/tipo_descuento.dart';
import 'package:agenda_front/models/enums/tipo_transaccion.dart';
import 'package:agenda_front/providers/persona_provider.dart';
import 'package:agenda_front/providers/transaccion_provider.dart';
import 'package:agenda_front/response.dart';
import 'package:agenda_front/ui/cards/white_card.dart';
import 'package:agenda_front/ui/inputs/custom_inputs.dart';
import 'package:agenda_front/ui/inputs/form_builder_currency.dart';
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
  List<Grupo>? grupos;

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
                      Row(children: [
                        SizedBox(height: defaultPadding),
                        Expanded(
                          child: Column(children: [
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
                              onChanged: (value) => setState(() {
                                provider.formKey.currentState?.fields['grupo']
                                    ?.didChange(null);
                                provider.formKey.currentState
                                    ?.fields['tipoBeneficio']
                                    ?.didChange(null);
                                provider.formKey.currentState
                                    ?.fields['tipoDescuento']
                                    ?.didChange(null);
                                grupos = value?.grupos;
                              }),
                            ),
                            if (grupos != null) ...[
                              SizedBox(height: defaultPadding),
                              FormBuilderSearchableDropdown(
                                name: 'grupo',
                                initialValue: widget.transaccion?.grupo,
                                enabled: widget.transaccion?.activo ?? true,
                                decoration: CustomInputs.form(
                                    label:
                                        'Asociar transacción a un grupo para descuento',
                                    hint: 'Seleccione un grupo',
                                    icon: Icons.supervised_user_circle),
                                compareFn: (item1, item2) =>
                                    item1.id!.contains(item2.id!),
                                items: grupos!,
                                onChanged: (value) {
                                  provider.formKey.currentState
                                      ?.fields['tipoBeneficio']
                                      ?.didChange(value?.beneficio?.tipo);
                                  provider.formKey.currentState
                                      ?.fields['tipoDescuento']
                                      ?.didChange(
                                          value?.beneficio?.tipoDescuento);
                                },
                              ),
                              SizedBox(height: defaultPadding),
                              FormBuilderDropdown(
                                  name: 'tipoBeneficio',
                                  initialValue:
                                      widget.transaccion?.tipoBeneficio,
                                  enabled: false,
                                  decoration: CustomInputs.form(
                                      label: 'Tipo de beneficio',
                                      hint: 'Seleccione un tipo',
                                      icon: Icons.info),
                                  items: TipoBeneficio.values
                                      .map((t) => DropdownMenuItem(
                                            value: t,
                                            child: Row(
                                              children: [
                                                Icon(t.icon),
                                                const SizedBox(
                                                    width: defaultPadding / 2),
                                                Text(toBeginningOfSentenceCase(
                                                    t.name.toLowerCase())!)
                                              ],
                                            ),
                                          ))
                                      .toList()),
                              SizedBox(height: defaultPadding),
                              FormBuilderDropdown(
                                  name: 'tipoDescuento',
                                  initialValue:
                                      widget.transaccion?.tipoDescuento,
                                  enabled: false,
                                  decoration: CustomInputs.form(
                                      label: 'Tipo de descuento',
                                      hint: 'Seleccione un tipo',
                                      icon: Icons.info),
                                  items: TipoDescuento.values
                                      .map((t) => DropdownMenuItem(
                                            value: t,
                                            child: Row(
                                              children: [
                                                Icon(t.icon),
                                                const SizedBox(
                                                    width: defaultPadding / 2),
                                                Text(toBeginningOfSentenceCase(
                                                    t.name.toLowerCase())!)
                                              ],
                                            ),
                                          ))
                                      .toList()),
                            ],
                            SizedBox(height: defaultPadding),
                            FormBuilderDropdown(
                              name: 'tipo',
                              initialValue: widget.transaccion?.tipo ??
                                  TipoTransaccion.VENTA,
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
                                          const SizedBox(
                                              width: defaultPadding / 2),
                                          Text(toBeginningOfSentenceCase(
                                              t.name.toLowerCase())!)
                                        ],
                                      )))
                                  .toList(),
                              validator: FormBuilderValidators.required(
                                  errorText: 'Campo obligatorio'),
                            ),
                            SizedBox(height: defaultPadding),
                            FormBuilderTextField(
                              name: 'activo-x',
                              initialValue:
                                  (widget.transaccion?.activo ?? false)
                                      ? 'ACTIVO'
                                      : 'INACTIVO',
                              enabled: false,
                              decoration: CustomInputs.form(
                                  label: 'Estado',
                                  hint: 'Estado',
                                  icon: Icons.info),
                            ),
                          ]),
                        ),
                        SizedBox(width: defaultPadding),
                        Expanded(
                          child: Column(children: [
                            FormBuilderCurrency(
                              name: 'sumatoria',
                              label: 'Sumatoria Total',
                              initialValue: widget.transaccion?.sumatoria ?? 0,
                            ),
                            SizedBox(height: defaultPadding),
                            FormBuilderCurrency(
                              name: 'descuento',
                              label: 'Descuento',
                              initialValue: widget.transaccion?.descuento ?? 0,
                            ),
                            SizedBox(height: defaultPadding),
                            FormBuilderCurrency(
                              name: 'Total',
                              label: 'Total a pagar',
                              initialValue: widget.transaccion?.total ?? 0,
                            ),
                          ]),
                        )
                      ]),
                    ],
                  )))
        ],
      ),
    );
  }
}
