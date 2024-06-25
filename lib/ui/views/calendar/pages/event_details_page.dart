// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/translate.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

import '../extension.dart';
import 'create_event_page.dart';

class DetailsPage extends StatelessWidget {
  final CalendarEventData event;

  const DetailsPage({super.key, required this.event});
  @override
  Widget build(BuildContext context) {
    Provider.of<AgendaProvider>(context);
    Agenda a = event.event as Agenda;
    return ListView(shrinkWrap : true, children : [
           physics: const ClampingScrollPhysics(),
           FormHeader(
            title: AppLocalizations.of(context)!.agenda('')),
            Divider(),
             Text(
            "${AppLocalizations.of(context)!.fecha}: ${event.date.dateToStringWithFormat(format: "dd/MM/yyyy")}"),
            Row(children: [
               Text(
            "${AppLocalizations.of(context)!.de}: ${event.date.dateToStringWithFormat(format: "HH:mm")}"),
            const SizedBox(width: mediumSizing),
             Text(
            "${AppLocalizations.of(context)!.a}: ${event.date.dateToStringWithFormat(format: "HH:mm")}"),
            ]),
            const SizedBox(height: mediumSizing),
             Row(children: [
              Icon(Icons.person),
            const SizedBox(width: mediumSizing),
             Text(a.persona.nombre),
            ]),
             const SizedBox(height: mediumSizing),
             Row(children: [
              Icon(Icons.person),
            const SizedBox(width: mediumSizing),
             Text(a.colaborador.nombre),
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
            Text(AppLocalizations.of(context)!.observacionesTag),
            Text(a.observacion),
            const SizedBox(height: mediumSizing),
            if(a.estado == null) ...[
             Row(children: [
              LinkButton(text: AppLocalizations.of(context)!.agenda('cancelar'), onPressed: (){
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child:
                            CancelarReservaModal(agenda: a);
                      );
                    },
                  );
              }),
            const SizedBox(width: mediumSizing),
              EButton(text: AppLocalizations.of(context)!.agenda('confirmarPresencia'),
              onPressed: () async {
                if(formKey.currentState!.saveAndValidate()){
                  final values = formKey.currentState!.values;
                  await Provider.of<AgendaProvider>(context, listen: false).cambiarEstado(a.id, Situacion.PRESENTE, observacion: 'Se inicia atención.');
                }
              },
              )
            ]),
            ] else if(a.situacion = Situacion.PRESENTE) ... [
              EButton(text: AppLocalizations.of(context)!.agenda('finalizar'), color: Colors.green, onPressed:  onPressed: () async {
                if(formKey.currentState!.saveAndValidate()){
                  final values = formKey.currentState!.values;
                  await Provider.of<AgendaProvider>(context, listen: false).cambiarEstado(a.id, Situacion.PRESENTE, observacion: 'Se finaliza atención.');
                }
              },),
            ] else ... [
               LinkButton(text: 'Puede verificar el historial de registros' onPressed: (){
                print('Se debe destacar el historial pestañeando unos segundos');
              }, color: Colors.grey),
            ]
    ]);
  }
}
