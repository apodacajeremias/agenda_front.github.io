import 'package:agenda_front/constants.dart';
import 'package:agenda_front/extensions.dart';
import 'package:agenda_front/providers.dart';
import 'package:agenda_front/src/models/entities/agenda.dart';
import 'package:agenda_front/src/models/entities/agenda_detalle.dart';
import 'package:agenda_front/translate.dart';
import 'package:agenda_front/ui/custom_inputs.dart';
import 'package:agenda_front/ui/widgets/elevated_button.dart';
import 'package:agenda_front/ui/widgets/link_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class AgendaDetalleModal extends StatelessWidget {
  final Agenda agenda;
  final AgendaDetalle? detalle;
  const AgendaDetalleModal({super.key, required this.agenda, this.detalle});

  @override
  Widget build(BuildContext context) {
    final idDetalle = detalle?.id;
    final provider = Provider.of<AgendaDetalleProvider>(context, listen: false);
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
            FormBuilderTextField(
                name: 'nombre',
                initialValue: detalle?.nombre ??
                    AppLocalizations.of(context)!.seguimiento,
                decoration: CustomInputs.form(
                    label: AppLocalizations.of(context)!.seguimiento,
                    hint: AppLocalizations.of(context)!.seguimiento,
                    icon: Icons.info)),
            const SizedBox(height: defaultSizing),
            FormBuilderTextField(
              name: 'observacion',
              initialValue: detalle?.observacion,
              keyboardType: TextInputType.multiline,
              minLines: 2,
              maxLines: 5,
              decoration: CustomInputs.form(
                  label: AppLocalizations.of(context)!.observacionesTag,
                  hint: AppLocalizations.of(context)!.observacionesTag,
                  icon: Icons.comment_rounded),
            ),
            const SizedBox(height: defaultSizing),
            Row(
              children: [
                Expanded(child: LinkButton.cancel(onPressed: () {
                  Navigator.of(context).pop();
                })),
                const SizedBox(width: defaultSizing),
                // TODO: cambiar por FormFooter
                Expanded(
                  flex: 2,
                  child: EButton(
                    onPressed: () async {
                      try {
                        if (provider.formKey.currentState!.saveAndValidate()) {
                          final data = provider.formKey.currentState!.value;
                          await provider.registrar(agenda.id, data,
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
