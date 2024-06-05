import 'package:agenda_front/constants.dart';
import 'package:agenda_front/src/models/entities/transaccion.dart';
import 'package:agenda_front/src/models/entities/transaccion_detalle.dart';
import 'package:agenda_front/translate.dart';
import 'package:agenda_front/ui/custom_inputs.dart';
import 'package:agenda_front/ui/views/item/item_dropdown.dart';
import 'package:agenda_front/ui/widgets/elevated_button.dart';
import 'package:agenda_front/ui/widgets/link_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TransaccionDetalleModal extends StatelessWidget {
  final Transaccion transaccion;
  final TransaccionDetalle? detalle;
  const TransaccionDetalleModal(
      {super.key, required this.transaccion, this.detalle});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return Container(
      margin: const EdgeInsets.only(top: maximumSizing),
      padding: const EdgeInsets.symmetric(horizontal: defaultSizing),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 370),
          child: FormBuilder(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: defaultSizing),
                ItemSearchableDropdown(name: 'item', unique: detalle?.item),
                const SizedBox(height: defaultSizing),
                FormBuilderTextField(
                  name: 'cantidad',
                  initialValue: (detalle?.cantidad ?? 1).toString(),
                  decoration: CustomInputs.form(
                      label: AppLocalizations.of(context)!.cantidad,
                      hint: AppLocalizations.of(context)!.cantidad,
                      icon: Icons.numbers_sharp),
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
                  name: 'subtotal',
                  initialValue: (detalle?.subtotal ?? 0).toString(),
                  decoration: CustomInputs.form(
                      label: AppLocalizations.of(context)!.subtotal,
                      hint: AppLocalizations.of(context)!.subtotal,
                      icon: Icons.price_change),
                ),
                const SizedBox(height: defaultSizing),
                Row(
                  children: [
                    EButton(
                      onPressed: () {
                        print('Confirmar pressed');
                      },
                      text: AppLocalizations.of(context)!.confirmar,
                    ),
                    const SizedBox(width: defaultSizing),
                    LinkButton(
                      text: AppLocalizations.of(context)!.cancelar,
                      onPressed: () {
                        print('Cancelar pressed');
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
