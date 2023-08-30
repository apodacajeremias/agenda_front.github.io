// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/constants.dart';
import 'package:agenda_front/models/entities/beneficio.dart';
import 'package:agenda_front/models/enums/tipo_beneficio.dart';
import 'package:agenda_front/models/enums/tipo_descuento.dart';
import 'package:agenda_front/providers/beneficio_provider.dart';
import 'package:agenda_front/ui/cards/white_card.dart';
import 'package:agenda_front/ui/inputs/custom_inputs.dart';
import 'package:agenda_front/ui/shared/forms/form_footer.dart';
import 'package:agenda_front/ui/shared/forms/form_header.dart';
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
      padding: EdgeInsets.all(defaultPadding),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          FormHeader(title: 'Beneficio'),
          WhiteCard(
            title: beneficio?.nombre,
            child: FormBuilder(
              key: provider.formKey,
              child: Column(
                children: [
                  if (beneficio?.id != null) ...[
                    const SizedBox(height: defaultPadding),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: FormBuilderTextField(
                              name: 'ID',
                              initialValue: beneficio?.id,
                              enabled: false,
                              decoration: CustomInputs.form(
                                  label: 'ID', hint: 'ID', icon: Icons.qr_code),
                            )),
                        const SizedBox(width: defaultPadding),
                        Expanded(
                            child: FormBuilderSwitch(
                          name: 'activo',
                          title: const Text('Estado del registro'),
                          initialValue: beneficio?.activo,
                          decoration: CustomInputs.noBorder(),
                        )),
                      ],
                    )
                  ],
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                            name: 'nombre',
                            initialValue: beneficio?.nombre,
                            enabled: beneficio?.activo ?? true,
                            decoration: CustomInputs.form(
                                label: 'Nombre del beneficio',
                                hint: 'Nombre',
                                icon: Icons.info),
                            validator: FormBuilderValidators.required(
                                errorText: 'Campo obligatorio')),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          child: FormBuilderTextField(
                        name: 'descuento',
                        initialValue: beneficio?.descuento.toString(),
                        enabled: beneficio?.activo ?? true,
                        decoration: CustomInputs.form(
                            label: 'Valor del beneficio',
                            hint: 'Valor de descuento',
                            icon: Icons.tag),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Campo obligatorio'),
                          FormBuilderValidators.min(0)
                        ]),
                      ))
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(children: [
                    Expanded(
                        child: FormBuilderDropdown(
                      name: 'tipo',
                      initialValue: beneficio?.tipo,
                      enabled: beneficio?.activo ?? true,
                      decoration: CustomInputs.form(
                          label: 'Tipo de beneficio',
                          hint: 'Tipo de beneficio',
                          icon: Icons.loyalty),
                      items: TipoBeneficio.values
                          .map((tipo) => DropdownMenuItem(
                              value: tipo,
                              child:
                                  Text(toBeginningOfSentenceCase(tipo.name)!)))
                          .toList(),
                      validator: FormBuilderValidators.required(
                          errorText: 'Campo obligatorio'),
                      valueTransformer: (value) => value?.name,
                    )),
                    SizedBox(width: 10),
                    Expanded(
                        child: FormBuilderDropdown(
                      name: 'tipoDescuento',
                      initialValue: beneficio?.tipoDescuento,
                      enabled: beneficio?.activo ?? true,
                      decoration: CustomInputs.form(
                          label: 'Tipo de descuento',
                          hint: 'Tipo de descuento',
                          icon: Icons.discount),
                      items: TipoDescuento.values
                          .map((descuento) => DropdownMenuItem(
                              value: descuento,
                              child: Text(
                                  toBeginningOfSentenceCase(descuento.name)!)))
                          .toList(),
                      validator: FormBuilderValidators.required(
                          errorText: 'Campo obligatorio'),
                      valueTransformer: (value) => value?.name,
                    ))
                  ]),
                  FormFooter(onConfirm: () async {
                    if (provider.saveAndValidate()) {
                      final data = provider.formData();
                      await provider.registrar(data);
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    }
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
