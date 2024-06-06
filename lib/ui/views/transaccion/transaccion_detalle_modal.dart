import 'package:agenda_front/constants.dart';
import 'package:agenda_front/extensions.dart';
import 'package:agenda_front/providers.dart';
import 'package:agenda_front/src/models/entities/transaccion.dart';
import 'package:agenda_front/src/models/entities/transaccion_detalle.dart';
import 'package:agenda_front/translate.dart';
import 'package:agenda_front/ui/custom_inputs.dart';
import 'package:agenda_front/ui/views/item/item_dropdown.dart';
import 'package:agenda_front/ui/widgets/elevated_button.dart';
import 'package:agenda_front/ui/widgets/link_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class TransaccionDetalleModal extends StatelessWidget {
  final Transaccion transaccion;
  final TransaccionDetalle? detalle;
  const TransaccionDetalleModal(
      {super.key, required this.transaccion, this.detalle});

  @override
  Widget build(BuildContext context) {
    final idDetalle = detalle?.id;
    final provider = Provider.of<TransaccionDetalleProvider>(context);
    return Container(
      padding: const EdgeInsets.all(defaultSizing),
      width: 400,
      child: FormBuilder(
        key: provider.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: defaultSizing),
            Text(
              AppLocalizations.of(context)!
                  .item(detalle != null ? 'editar' : 'asignar'),
              style: context.titleLarge,
            ),
            const SizedBox(height: defaultSizing),
            ItemSearchableDropdown(
              name: 'item',
              tipo: transaccion.tipo,
              unique: detalle?.item,
              onChanged: (itm) {
                provider.formKey.currentState!.fields['valor']!
                    .didChange(itm?.precio ?? 0);
              },
            ),
            const SizedBox(height: defaultSizing),
            FormBuilderTextField(
              name: 'cantidad',
              initialValue: (detalle?.cantidad ?? 1).toString(),
              decoration: CustomInputs.form(
                  label: AppLocalizations.of(context)!.cantidad,
                  hint: AppLocalizations.of(context)!.cantidad,
                  icon: Icons.numbers_sharp),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.numeric(
                    errorText: AppLocalizations.of(context)!.soloNumeros),
                FormBuilderValidators.required(
                    errorText: AppLocalizations.of(context)!.campoObligatorio)
              ]),
              onChanged: (value) {
                double c =
                    provider.formKey.currentState!.fields['cantidad']?.value ??
                        1;
                double v =
                    provider.formKey.currentState!.fields['valor']?.value ?? 0;
                provider.formKey.currentState!.fields['-subtotal']!
                    .didChange(c * v);
              },
            ),
            const SizedBox(height: defaultSizing),
            FormBuilderTextField(
              name: 'valor',
              initialValue: (detalle?.valor ?? 0).toString(),
              decoration: CustomInputs.form(
                  label: AppLocalizations.of(context)!.valor,
                  hint: AppLocalizations.of(context)!.valor,
                  icon: Icons.price_change_outlined),
            ),
            const SizedBox(height: defaultSizing),
            FormBuilderTextField(
              name: '-subtotal',
              initialValue: (detalle?.subtotal ?? 0).toString(),
              decoration: CustomInputs.form(
                  label: AppLocalizations.of(context)!.subtotal,
                  hint: AppLocalizations.of(context)!.subtotal,
                  icon: Icons.price_change),
            ),
            const SizedBox(height: defaultSizing),
            Row(
              children: [
                Expanded(child: LinkButton.cancel(onPressed: () {
                  Navigator.of(context).pop();
                })),
                const SizedBox(width: defaultSizing),
                Expanded(
                  flex: 2,
                  child: EButton(
                    onPressed: () async {
                      try {
                        if (provider.formKey.currentState!.saveAndValidate()) {
                          final data = provider.formKey.currentState!.value;
                          await provider.registrar(transaccion.id, data,
                              idDetalle: idDetalle);
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        }
                      } catch (e) {
                        rethrow;
                      }
                    },
                    text: AppLocalizations.of(context)!.confirmar,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
