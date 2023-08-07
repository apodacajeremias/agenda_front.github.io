// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/models/entities/agenda.dart';
import 'package:agenda_front/providers/agenda_provider.dart';
import 'package:agenda_front/utils/fecha_util.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/services/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgendaDataSource extends DataTableSource {
  final List<Agenda> agendas;
  final BuildContext context;

  AgendaDataSource(this.agendas, this.context);

  @override
  DataRow? getRow(int index) {
    final agenda = agendas[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(agenda.persona!.nombre!)),
      DataCell(Text(FechaUtil.formatDate(agenda.fecha!))),
      DataCell(Text(FechaUtil.formatTime(agenda.hora!))),
      DataCell(Text(agenda.colaborador!.nombre!)),
      DataCell(Text(agenda.prioridad.toString())),
      DataCell(Row(children: [
        IconButton(
          onPressed: () {
            NavigationService.navigateTo('/agendas/${agenda.id}');
          },
          icon: Icon(Icons.edit),
        ),
        IconButton(
            onPressed: () {
              final dialog = AlertDialog(
                  title: Text('Estas seguro de cancelarlo?'),
                  content:
                      Text('Cancelar agendamiento de $agenda.persona.nombre?'),
                  actions: [
                    TextButton(
                      child: Text('No, mantener'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                        child: Text('Si, cancelar'),
                        onPressed: () async {
                          var confirmado = await Provider.of<AgendaProvider>(
                                  context,
                                  listen: false)
                              .eliminar(agenda.id!);
                          if (confirmado) {
                            NotificationsService.showSnackbar(
                                'Agendamiento cancelado');
                          } else {
                            NotificationsService.showSnackbar(
                                'Agendamiento no ha sido cancelado');
                          }
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        }),
                  ]);
              showDialog(context: context, builder: (_) => dialog);
            },
            icon: Icon(Icons.delete),
            )
      ]))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => agendas.length;

  @override
  int get selectedRowCount => 0;
}
