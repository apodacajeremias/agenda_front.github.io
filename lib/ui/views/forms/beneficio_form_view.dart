// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/models/entities/beneficio.dart';
import 'package:agenda_front/models/enums/tipo_beneficio.dart';
import 'package:agenda_front/models/enums/tipo_descuento.dart';
import 'package:agenda_front/providers/beneficio_provider.dart';
import 'package:agenda_front/ui/buttons/link_text.dart';
import 'package:agenda_front/ui/cards/white_card.dart';
import 'package:agenda_front/ui/inputs/custom_inputs.dart';
import 'package:agenda_front/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BeneficioFormView extends StatelessWidget {
  final Beneficio? beneficio;
  const BeneficioFormView({super.key, this.beneficio});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BeneficioProvider>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Formulario',
                style: CustomLabels.h1,
              ),
              LinkText(
                  text: 'Volver',
                  color: Colors.blue.withOpacity(0.4),
                  onPressed: () => Navigator.of(context).pop())
            ],
          ),
          WhiteCard(
            title: beneficio?.nombre,
            child: FormBuilder(
              key: provider.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (beneficio?.id == null) ...[
                    SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: FormBuilderTextField(
                                  name: 'id',
                                  initialValue: beneficio?.id,
                                  enabled: false,
                                  decoration: CustomInputs.iphone(
                                      label: 'ID', icon: Icons.qr_code))),
                          SizedBox(width: 10),
                          Expanded(
                              child: FormBuilderSwitch(
                                  name: 'activo',
                                  title: Text(
                                    'Estado del registro',
                                    style: CustomLabels.h3,
                                  ),
                                  initialValue: beneficio?.activo,
                                  decoration: CustomInputs.noBorder()))
                        ])
                  ],
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                            name: 'nombre',
                            initialValue: beneficio?.nombre,
                            enabled: beneficio?.activo ?? true,
                            decoration: CustomInputs.windows11(
                                label: 'Nombre del beneficio',
                                icon: Icons.info),
                            validator: FormBuilderValidators.required(
                                errorText: 'Campo obligatorio')),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          child: FormBuilderTextField(
                        name: 'descuento',
                        initialValue: beneficio?.descuento as String,
                        enabled: beneficio?.activo ?? true,
                        decoration: CustomInputs.iphone(
                            label: 'Valor del beneficio', icon: Icons.tag),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Campo obligatorio'),
                          FormBuilderValidators.min(0)
                        ]),
                      ))
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: FormBuilderDropdown(
                                name: 'tipo',
                                initialValue: beneficio?.tipo,
                                enabled: beneficio?.activo ?? true,
                                decoration: CustomInputs.windows11(
                                    label: 'Tipo de beneficio',
                                    icon: Icons.loyalty),
                                items: TipoBeneficio.values
                                    .map((tipo) => DropdownMenuItem(
                                        value: tipo.name,
                                        child: Text(toBeginningOfSentenceCase(
                                            tipo.name)!)))
                                    .toList())),
                        SizedBox(width: 10),
                        Expanded(
                            child: FormBuilderDropdown(
                                name: 'tipoDescuento',
                                initialValue: beneficio?.tipoDescuento,
                                enabled: beneficio?.activo ?? true,
                                decoration: CustomInputs.iphone(
                                    label: 'Tipo de descuento',
                                    icon: Icons.discount),
                                items: TipoDescuento.values
                                    .map((descuento) => DropdownMenuItem(
                                        value: descuento.name,
                                        child: Text(toBeginningOfSentenceCase(
                                            descuento.name)!)))
                                    .toList()))
                      ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
