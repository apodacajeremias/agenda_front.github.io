import 'package:agenda_front/constants.dart';
import 'package:agenda_front/enums.dart';
import 'package:agenda_front/providers.dart';
import 'package:agenda_front/src/models/entities/agenda.dart';
import 'package:agenda_front/translate.dart';
import 'package:agenda_front/ui/custom_inputs.dart';
import 'package:agenda_front/ui/widgets/form_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:provider/provider.dart';

class CancelarReservaModal extends StatelessWidget {
  final Agenda agenda;

  const CancelarReservaModal({super.key, required this.agenda});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return FormBuilder(
        key: formKey,
        child: Column(children: [
          const SizedBox(height: mediumSizing),
          Row(children: [
            Icon(Icons.person),
            const SizedBox(width: mediumSizing),
            Text(agenda.persona.nombre),
          ]),
          const SizedBox(height: mediumSizing),
          Row(children: [
            Icon(Icons.person),
            const SizedBox(width: mediumSizing),
            Text(agenda.colaborador.nombre),
          ]),
          const SizedBox(height: mediumSizing),
          Text(AppLocalizations.of(context)!.prioridad),
          const SizedBox(height: mediumSizing),
          Row(children: [
            Icon(agenda.prioridad.icon),
            const SizedBox(width: mediumSizing),
            Text(agenda.prioridad.toString()),
          ]),
          const SizedBox(height: mediumSizing),
          Divider(),
          const SizedBox(height: mediumSizing),
          FormBuilderSearchableDropdown(
            name: 'situacion',
            decoration: CustomInputs.form(
                label: AppLocalizations.of(context)!.situacion,
                hint: AppLocalizations.of(context)!.situacion,
                icon: Icons.info_rounded),
            items: [
              Situacion.CANCELADO,
              Situacion.AUSENTE,
              Situacion.ATRASADO,
            ],
            compareFn: (item1, item2) => item1 == item2,
          ),
          const SizedBox(height: mediumSizing),
          FormBuilderTextField(
            name: 'observacion',
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
            if (formKey.currentState!.saveAndValidate()) {
              final values = formKey.currentState!.value;
              await Provider.of<AgendaDetalleProvider>(context, listen: false)
                  .cambiarEstado(agenda.id, values['situacion'],
                      observacion: values['situacion']);
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            }
          })
        ]));
  }
}
