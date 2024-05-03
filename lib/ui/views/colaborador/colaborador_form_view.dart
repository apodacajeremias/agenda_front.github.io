import 'package:agenda_front/constants.dart';
import 'package:agenda_front/providers.dart';
import 'package:agenda_front/src/models/entities/colaborador.dart';
import 'package:agenda_front/ui/custom_inputs.dart';
import 'package:agenda_front/ui/widgets/form_footer.dart';
import 'package:agenda_front/ui/widgets/form_header.dart';
import 'package:agenda_front/ui/widgets/white_card.dart';
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
      padding: EdgeInsets.all(defaultSizing),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          FormHeader(title: 'Colaborador'),
          WhiteCard(
            child: FormBuilder(
              key: provider.formKey,
              child: Column(
                children: [
                  if (colaborador?.id != null) ...[
                    const SizedBox(height: defaultSizing),
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
                        const SizedBox(width: defaultSizing),
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
                  SizedBox(height: defaultSizing),
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
                  SizedBox(height: defaultSizing),
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
                      SizedBox(width: defaultSizing),
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
