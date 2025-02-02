import 'package:agenda_front/constants.dart';
import 'package:agenda_front/providers.dart';
import 'package:agenda_front/src/models/entities/beneficio.dart';
import 'package:agenda_front/src/models/enums/tipo_beneficio.dart';
import 'package:agenda_front/src/models/enums/tipo_descuento.dart';
import 'package:agenda_front/translate.dart';
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
          FormHeader(
              title: beneficio?.id == null
                  ? AppLocalizations.of(context)!.beneficio('registrar')
                  : AppLocalizations.of(context)!.beneficio('editar')),
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
                              name: 'id',
                              initialValue: beneficio?.id,
                              enabled: false,
                              decoration: CustomInputs.form(
                                  label: AppLocalizations.of(context)!.idTag,
                                  hint: AppLocalizations.of(context)!.idHint,
                                  icon: Icons.qr_code),
                            )),
                        const SizedBox(width: defaultSizing),
                        Expanded(
                            child: FormBuilderSwitch(
                          name: 'estado',
                          title: Text(AppLocalizations.of(context)!.actigoTag),
                          initialValue: beneficio?.estado,
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
                            enabled: beneficio?.estado ?? true,
                            decoration: CustomInputs.form(
                                label: AppLocalizations.of(context)!.nombreTag,
                                hint: AppLocalizations.of(context)!.nombreHint,
                                icon: Icons.info),
                            validator: FormBuilderValidators.required(
                              errorText: AppLocalizations.of(context)!
                                  .nombreObligatorio,
                            )),
                      ),
                      const SizedBox(width: defaultSizing),
                      Expanded(
                          child: FormBuilderTextField(
                        name: 'descuento',
                        initialValue: beneficio?.descuento.toString(),
                        enabled: beneficio?.estado ?? true,
                        decoration: CustomInputs.form(
                            label: AppLocalizations.of(context)!.descuento,
                            hint: AppLocalizations.of(context)!.descuento,
                            icon: Icons.tag),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText:
                                AppLocalizations.of(context)!.campoObligatorio,
                          ),
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
                      enabled: beneficio?.estado ?? true,
                      decoration: CustomInputs.form(
                          label:
                              AppLocalizations.of(context)!.tipo('beneficio'),
                          hint: AppLocalizations.of(context)!.tipo('beneficio'),
                          icon: Icons.loyalty),
                      items: TipoBeneficio.values
                          .map((tipo) => DropdownMenuItem(
                              value: tipo,
                              child:
                                  Text(toBeginningOfSentenceCase(tipo.name)!)))
                          .toList(),
                      validator: FormBuilderValidators.required(
                          errorText:
                              AppLocalizations.of(context)!.campoObligatorio),
                      valueTransformer: (value) => value?.name,
                    )),
                    const SizedBox(width: defaultSizing),
                    Expanded(
                        child: FormBuilderDropdown(
                      name: 'tipoDescuento',
                      initialValue: beneficio?.tipoDescuento,
                      enabled: beneficio?.estado ?? true,
                      decoration: CustomInputs.form(
                          label:
                              AppLocalizations.of(context)!.tipo('descuento'),
                          hint: AppLocalizations.of(context)!.tipo('descuento'),
                          icon: Icons.discount),
                      items: TipoDescuento.values
                          .map((descuento) => DropdownMenuItem(
                              value: descuento,
                              child: Text(
                                  toBeginningOfSentenceCase(descuento.name)!)))
                          .toList(),
                      validator: FormBuilderValidators.required(
                          errorText:
                              AppLocalizations.of(context)!.campoObligatorio),
                      valueTransformer: (value) => value?.name,
                    ))
                  ]),
                  const SizedBox(height: defaultSizing),
                  FormBuilderTextField(
                    name: 'observacion',
                    initialValue: beneficio?.observacion,
                    keyboardType: TextInputType.multiline,
                    minLines: 2,
                    maxLines: 5,
                    decoration: CustomInputs.form(
                        label: AppLocalizations.of(context)!.observacionesTag,
                        hint: AppLocalizations.of(context)!.observacionesTag,
                        icon: Icons.comment_rounded),
                  ),
                  const SizedBox(height: defaultSizing),
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
