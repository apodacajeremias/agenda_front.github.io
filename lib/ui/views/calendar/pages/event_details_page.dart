// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/constants.dart';
import 'package:agenda_front/enums.dart';
import 'package:agenda_front/providers.dart';
import 'package:agenda_front/src/models/entities/agenda.dart';
import 'package:agenda_front/translate.dart';
import 'package:agenda_front/ui/views/agenda/agenda_datasource.dart';
import 'package:agenda_front/ui/views/agenda/agenda_detalle_modal.dart';
import 'package:agenda_front/ui/views/agenda/cancelar_reserva_modal.dart';
import 'package:agenda_front/ui/views/auth/page_not_found_view.dart';
import 'package:agenda_front/ui/widgets/elevated_button.dart';
import 'package:agenda_front/ui/widgets/form_header.dart';
import 'package:agenda_front/ui/widgets/index.dart';
import 'package:agenda_front/ui/widgets/link_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../extension.dart';

class DetailsPage extends StatelessWidget {
  final String id;

  const DetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    // return _AgendaTimeline();
    return FutureBuilder(
      future:
          Provider.of<AgendaDetalleProvider>(context, listen: false).buscar(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox.square(
              dimension: 200, child: CircularProgressIndicator.adaptive());
        } else if (snapshot.hasData) {
          return _Details();
        } else {
          return PageNotFoundView();
        }
      },
    );
  }
}

class _Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AgendaDetalleProvider>(context);
    final agenda = provider.agenda!;
    return ListView(
      children: [
        FormHeader(title: AppLocalizations.of(context)!.agenda('')),
        const SizedBox(height: maximumSizing),
        _AgendaDetails(
          agenda: agenda,
        ),
        _AgendaTimeline(
          agenda: agenda,
        )
      ],
    );
  }
}

class _AgendaDetails extends StatelessWidget {
  final Agenda agenda;
  const _AgendaDetails({required this.agenda});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(mediumSizing),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.calendar_month),
            const SizedBox(width: mediumSizing),
            Text(agenda.inicio.dateToStringWithFormat(format: "dd/MM/yyyy")),
          ]),
          const SizedBox(height: mediumSizing),
          Row(children: [
            Icon(Icons.hourglass_top),
            Text(
                "${AppLocalizations.of(context)!.de} ${timeFormat.format(agenda.inicio)}"),
            const SizedBox(width: mediumSizing),
            Icon(Icons.hourglass_bottom),
            Text(
                "${AppLocalizations.of(context)!.a} ${timeFormat.format(agenda.fin)}"),
          ]),
          const SizedBox(height: mediumSizing),
          Row(children: [
            Icon(Icons.person),
            const SizedBox(width: mediumSizing),
            Text(agenda.persona.nombre),
          ]),
          const SizedBox(height: mediumSizing),
          Row(children: [
            Icon(Icons.person_add),
            const SizedBox(width: mediumSizing),
            Text(agenda.colaborador.nombre),
          ]),
          const SizedBox(height: mediumSizing),
          Row(children: [
            Icon(agenda.prioridad.icon),
            const SizedBox(width: mediumSizing),
            Text(
                '${AppLocalizations.of(context)!.prioridad} ${agenda.prioridad}'),
          ]),
          const SizedBox(height: mediumSizing),
          Row(children: [
            Icon(Icons.info),
            const SizedBox(width: mediumSizing),
            Text(agenda.situacion.toString()),
          ]),
          const SizedBox(height: mediumSizing),
          Row(children: [
            Icon(Icons.info),
            Text(AppLocalizations.of(context)!.observacionesTag),
            const SizedBox(width: mediumSizing),
            Text(agenda.observacion ?? 'Sin observaciones.'),
          ]),
          const SizedBox(height: mediumSizing),
          if (agenda.estado == null) ...[
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              EButton(
                color: Colors.green,
                text:
                    AppLocalizations.of(context)!.agenda('confirmarPresencia'),
                onPressed: () async {
                  if (context.mounted) {
                    await Provider.of<AgendaDetalleProvider>(context,
                            listen: false)
                        .cambiarEstado(agenda.id, Situacion.PRESENTE,
                            observacion: 'Se inicia atención.');
                  }
                },
              ),
              const SizedBox(width: mediumSizing),
              LinkButton(
                  text: AppLocalizations.of(context)!.agenda('cancelar'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                            child: CancelarReservaModal(agenda: agenda));
                      },
                    );
                  }),
            ]),
          ] else if (agenda.situacion == Situacion.PRESENTE) ...[
            EButton(
              text: AppLocalizations.of(context)!.agenda('finalizar'),
              color: Colors.amber,
              onPressed: () async {
                if (context.mounted) {
                  await Provider.of<AgendaDetalleProvider>(context,
                          listen: false)
                      .cambiarEstado(agenda.id, Situacion.FINALIZADO,
                          observacion: 'Se finaliza atención.');
                }
              },
            ),
          ] else ...[
            LinkButton(
                text: 'Puede verificar el historial de registros',
                onPressed: () {
                  print(
                      'Se debe destacar el historial pestañeando unos segundos');
                },
                color: Colors.grey),
          ]
        ],
      ),
    );
  }
}

class _AgendaTimeline extends StatelessWidget {
  final Agenda agenda;

  const _AgendaTimeline({required this.agenda});
  @override
  Widget build(BuildContext context) {
    return Index(
        title: AppLocalizations.of(context)!.historial,
        subtitle: AppLocalizations.of(context)!.historialDetallado,
        actions: [
          EButton(
            text: AppLocalizations.of(context)!.accion('agregar'),
            icon: Icons.comment,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: AgendaDetalleModal(agenda: agenda),
                  );
                },
              );
            },
          )
        ],
        columns: AgendaDetalleDataSource.columns,
        source: AgendaDetalleDataSource(agenda.detalles ?? [], context));
  }
}
