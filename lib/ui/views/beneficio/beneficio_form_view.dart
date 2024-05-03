import 'package:agenda_front/constants.dart';
import 'package:agenda_front/providers.dart';
import 'package:agenda_front/src/models/entities/beneficio.dart';
import 'package:agenda_front/src/models/enums/tipo_beneficio.dart';
import 'package:agenda_front/src/models/enums/tipo_descuento.dart';
import 'package:agenda_front/ui/custom_inputs.dart';
import 'package:agenda_front/ui/widgets/form_footer.dart';
import 'package:agenda_front/ui/widgets/form_header.dart';
import 'package:agenda_front/ui/widgets/white_card.dart';
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
      padding: const EdgeInsets.all(defaultSizing),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          FormHeader(title: 'Beneficio'),
          WhiteCard(
            child: FormBuilder(
              key: provider.formKey,
              child: Column(
                children: [
                  if (beneficio?.id != null) ...[
                    const SizedBox(height: defaultSizing),
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
                        const SizedBox(width: defaultSizing),
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
                  const SizedBox(height: defaultSizing),
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
                      const SizedBox(width: defaultSizing),
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
                  const SizedBox(height: defaultSizing),
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
                    const SizedBox(width: defaultSizing),
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
