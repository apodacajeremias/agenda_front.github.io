// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/models/entities/agenda.dart';
import 'package:agenda_front/providers/agenda_provider.dart';
import 'package:agenda_front/services/fecha_util.dart';
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
      DataCell(Text(agenda.nombre!)),
      DataCell(Text(FechaUtil.formatDate(agenda.fecha!))),
      DataCell(Text(FechaUtil.formatTime(agenda.hora!))),
      DataCell(Text(agenda.persona!.nombre!)),
      DataCell(Text(agenda.colaborador!.nombre!)),
      DataCell(Text(agenda.situacion.toString())),
      DataCell(Text(agenda.prioridad.toString())),
      DataCell(Row(children: [
        IconButton(
          onPressed: () {
            NavigationService.navigateTo('/dashboard/agendas/${agenda.id}');
          },
          icon: Icon(Icons.edit),
        ),
        IconButton(
            onPressed: () {
              final dialog = AlertDialog(
                  title: Text('Estas seguro de borrarlo?'),
                  content: Text(
                      'Borrar definitivamente agenda de $agenda.persona.nombre?'),
                  actions: [
                    TextButton(
                      child: Text('No, mantener'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                        child: Text('Si, borrar'),
                        onPressed: () async {
                          var confirmado = await Provider.of<AgendaProvider>(
                                  context,
                                  listen: false)
                              .eliminar(agenda.id!);
                          if (confirmado) {
                            NotificationsService.showSnackbar(
                                'Registro eliminado exitosamente');
                          } else {
                            NotificationsService.showSnackbar(
                                'Registro no ha sido eliminado');
                          }
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        }),
                  ]);
              showDialog(context: context, builder: (_) => dialog);
            },
            icon: Icon(Icons.delete),
            color: Colors.red.withOpacity(0.8))
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
