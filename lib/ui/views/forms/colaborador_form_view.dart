// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/constants.dart';
import 'package:agenda_front/models/entities/colaborador.dart';
import 'package:agenda_front/providers/colaborador_provider.dart';
import 'package:agenda_front/ui/cards/white_card.dart';
import 'package:agenda_front/ui/inputs/custom_inputs.dart';
import 'package:agenda_front/ui/shared/forms/form_footer.dart';
import 'package:agenda_front/ui/shared/forms/form_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class ColaboradorFormView extends StatelessWidget {
  final Colaborador? colaborador;
  const ColaboradorFormView({super.key, this.colaborador});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ColaboradorProvider>(context, listen: false);
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          FormHeader(title: 'Colaborador'),
          WhiteCard(
            title: colaborador?.nombre,
            child: FormBuilder(
              key: provider.formKey,
              child: Column(
                children: [
                  if (colaborador?.id != null) ...[
                    const SizedBox(height: defaultPadding),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: FormBuilderTextField(
                              name: 'ID',
                              initialValue: colaborador?.id,
                              enabled: false,
                              decoration: CustomInputs.form(
                                  label: 'ID', hint: 'ID', icon: Icons.qr_code),
                            )),
                        const SizedBox(width: defaultPadding),
                        Expanded(
                            child: FormBuilderSwitch(
                          name: 'activo',
                          title: const Text('Estado del registro'),
                          initialValue: colaborador?.activo,
                          decoration: CustomInputs.noBorder(),
                        )),
                      ],
                    )
                  ],
                  SizedBox(height: defaultPadding),
                  FormBuilderTextField(
                    name: 'profesion',
                    initialValue: colaborador?.profesion,
                    enabled: colaborador?.activo ?? true,
                    decoration: CustomInputs.form(
                        label: 'Profesión',
                        hint: 'Profesión',
                        icon: Icons.info),
                    validator: FormBuilderValidators.required(
                        errorText: 'Campo obligatorio'),
                  ),
                  SizedBox(height: defaultPadding),
                  Row(
                    children: [
                      Expanded(
                          child: FormBuilderTextField(
                        name: 'registroProfesional',
                        initialValue: colaborador?.registroProfesional,
                        enabled: colaborador?.activo ?? true,
                        decoration: CustomInputs.form(
                            label: 'Registro Profesional',
                            hint: 'Registro Profesional',
                            icon: Icons.request_quote),
                        validator: FormBuilderValidators.required(
                            errorText: 'Campo obligatorio'),
                      )),
                      SizedBox(width: defaultPadding),
                      Expanded(
                          child: FormBuilderTextField(
                        name: 'registroContribuyente',
                        initialValue: colaborador?.registroContribuyente,
                        enabled: colaborador?.activo ?? true,
                        decoration: CustomInputs.form(
                            label: 'Registro de Contribuyente',
                            hint: 'RUC, CNPJ, RUT',
                            icon: Icons.request_quote),
                        validator: FormBuilderValidators.required(
                            errorText: 'Campo obligatorio'),
                      ))
                    ],
                  ),
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
