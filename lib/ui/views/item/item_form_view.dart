import 'package:agenda_front/constants.dart';
import 'package:agenda_front/providers.dart';
import 'package:agenda_front/src/models/entities/item.dart';
import 'package:agenda_front/src/models/enums/tipo_transaccion.dart';
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

class ItemFormView extends StatelessWidget {
  final Item? item;
  const ItemFormView({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ItemProvider>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(defaultSizing),
      child: ListView(
        children: [
          FormHeader(
              title: item?.id == null
                  ? AppLocalizations.of(context)!.item('registrar')
                  : AppLocalizations.of(context)!.item('editar')),
          WhiteCard(
              child: FormBuilder(
                  key: provider.formKey,
                  child: Column(
                    children: [
                      if (item?.id != null) ...[
                        const SizedBox(height: defaultSizing),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: FormBuilderTextField(
                                  name: 'id',
                                  initialValue: item?.id,
                                  enabled: false,
                                  decoration: CustomInputs.form(
                                      label:
                                          AppLocalizations.of(context)!.idTag,
                                      hint:
                                          AppLocalizations.of(context)!.idHint,
                                      icon: Icons.qr_code),
                                )),
                            const SizedBox(width: defaultSizing),
                            Expanded(
                                child: FormBuilderSwitch(
                              name: 'estado',
                              title:
                                  Text(AppLocalizations.of(context)!.actigoTag),
                              initialValue: item?.estado,
                              decoration: CustomInputs.noBorder(),
                            )),
                          ],
                        )
                      ],
                      const SizedBox(height: defaultSizing),
                      FormBuilderTextField(
                          name: 'nombre',
                          initialValue: item?.nombre,
                          enabled: item?.estado ?? true,
                          decoration: CustomInputs.form(
                              label: 'Nombre',
                              hint: 'Nombre descriptivo',
                              icon: Icons.info),
                          validator: FormBuilderValidators.required(
                              errorText: AppLocalizations.of(context)!
                                  .nombreObligatorio)),
                      const SizedBox(height: defaultSizing),
                      Row(
                        children: [
                          Expanded(
                              child: FormBuilderTextField(
                            name: 'precio',
                            initialValue: item?.precio.toString(),
                            enabled: item?.estado ?? true,
                            decoration: CustomInputs.form(
                                label: AppLocalizations.of(context)!.precio,
                                hint: AppLocalizations.of(context)!.precio,
                                icon: Icons.info),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.numeric(
                                  errorText: AppLocalizations.of(context)!
                                      .soloNumeros),
                              FormBuilderValidators.required(
                                  errorText: AppLocalizations.of(context)!
                                      .campoObligatorio)
                            ]),
                          )),
                          const SizedBox(width: defaultSizing),
                          Expanded(
                            child: FormBuilderDropdown(
                              name: 'tipo',
                              initialValue: item?.tipo,
                              enabled: item?.estado ?? true,
                              decoration: CustomInputs.form(
                                  label: AppLocalizations.of(context)!
                                      .tipo('item'),
                                  hint: AppLocalizations.of(context)!
                                      .tipo('item'),
                                  icon: Icons.info),
                              items: TipoTransaccion.values
                                  .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                          toBeginningOfSentenceCase(e.name)!)))
                                  .toList(),
                              validator: FormBuilderValidators.required(
                                  errorText: AppLocalizations.of(context)!
                                      .campoObligatorio),
                              valueTransformer: (value) => value.toString(),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: defaultSizing),
                      FormBuilderTextField(
                        name: 'observacion',
                        initialValue: item?.observacion,
                        keyboardType: TextInputType.multiline,
                        minLines: 2,
                        maxLines: 5,
                        decoration: CustomInputs.form(
                            label:
                                AppLocalizations.of(context)!.observacionesTag,
                            hint:
                                AppLocalizations.of(context)!.observacionesTag,
                            icon: Icons.comment_rounded),
                      ),
                      const SizedBox(height: defaultSizing),
                      FormFooter(onConfirm: () async {
                        if (provider.saveAndValidate()) {
                          try {
                            await provider.registrar(provider.formData());
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          } catch (e) {
                            rethrow;
                          }
                        }
                      })
                    ],
                  )))
        ],
      ),
    );
  }
}
