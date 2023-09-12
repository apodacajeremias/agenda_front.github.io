import 'package:agenda_front/models/entities/agenda.dart';
import 'package:agenda_front/providers/agenda_provider.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/services/notifications_service.dart';
import 'package:agenda_front/utils/fecha_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgendaDataSource extends DataTableSource {
  final List<Agenda> agendas;
  final BuildContext context;

  AgendaDataSource(this.agendas, this.context);

  static List<DataColumn> columns = [
    const DataColumn(label: Text('Persona')),
    const DataColumn(label: Text('Colaborador')),
    const DataColumn(label: Text('Inicio')),
    const DataColumn(label: Text('Fin')),
    const DataColumn(label: Text('Acciones')),
  ];

  @override
  DataRow? getRow(int index) {
    final agenda = agendas[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(agenda.persona!.nombre!)),
      DataCell(Text(agenda.colaborador!.nombre!)),
      DataCell(Text(FechaUtil.formatDateTime(agenda.inicio!))),
      DataCell(Text(FechaUtil.formatDateTime(agenda.fin!))),
      DataCell(Row(children: [
        IconButton(
          onPressed: () {
            NavigationService.navigateTo('/agendas/${agenda.id}');
          },
          icon: const Icon(Icons.edit),
        ),
        IconButton(
            onPressed: () {
              final dialog = AlertDialog(
                  title: const Text('Estas seguro de borrarlo?'),
                  content: Text('Borrar agenda $agenda.nombre?'),
                  actions: [
                    TextButton(
                      child: const Text('No, mantener'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                        child: const Text('Si, borrar'),
                        onPressed: () async {
                          var confirmado = await Provider.of<AgendaProvider>(
                                  context,
                                  listen: false)
                              .eliminar(agenda.id);
                          if (confirmado) {
                            NotificationsService.showSnackbar(
                                'Agenda eliminada exitosamente');
                          } else {
                            NotificationsService.showSnackbar(
                                'Agenda no ha sido eliminada');
                          }
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        }),
                  ]);
              showDialog(context: context, builder: (_) => dialog);
            },
            icon: const Icon(Icons.delete))
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

class AgendaDataSourceProfile extends DataTableSource {
  final List<Agenda> agendas;
  final BuildContext context;

  AgendaDataSourceProfile(this.agendas, this.context);

  static List<DataColumn> columns = [
    const DataColumn(label: Text('Colaborador')),
    const DataColumn(label: Text('Inicio')),
    const DataColumn(label: Text('Fin')),
  ];

  @override
  DataRow? getRow(int index) {
    final agenda = agendas[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(agenda.colaborador!.nombre!)),
      DataCell(Text(FechaUtil.formatDateTime(agenda.inicio!))),
      DataCell(Text(FechaUtil.formatDateTime(agenda.fin!))),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => agendas.length;

  @override
  int get selectedRowCount => 0;
}
