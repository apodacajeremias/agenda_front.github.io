import 'package:flutter/material.dart';

class CancelarReservaModal extends StatelessWidget{
    final Agenda agenda;

const CancelarReservaModal({required this.agenda});


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
              Icon(a.prioridad.icon),
            const SizedBox(width: mediumSizing),
             Text(a.prioridad),
            ]),
            const SizedBox(height: mediumSizing),
            if(situaciones.length > 1) ...[
            Divider(),
            const SizedBox(height: mediumSizing),
            FormBuilderSearchableDropdown(
              name: 'situacion',
              decoration: CustomInputs.form(
                  label: AppLocalizations.of(context)!
                      .situacion,
                  hint: AppLocalizations.of(context)!
                      .situacion,
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
            FormModal(onConfirm: () async {
              if(formKey.currentState!.saveAndValidate()){
                  final values = formKey.currentState!.values;
                  await Provider.of<AgendaProvider>(context, listen: false).cambiarEstado(a.id, values['situacion'], observacion: values['situacion']);
                if(context.mounted){
                  Navigator.of(context).pop()
                }
                }
            })
            ],

        ])
    );
  }
}