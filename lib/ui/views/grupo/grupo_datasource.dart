import 'package:agenda_front/providers.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/entities/grupo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GrupoDataSource extends DataTableSource {
  final List<Grupo> grupos;
  final BuildContext context;

  GrupoDataSource(this.grupos, this.context);

  static List<DataColumn> columns = [
    const DataColumn(label: Text('Grupo')),
    const DataColumn(label: Text('Beneficio')),
    const DataColumn(label: Text('Acciones')),
  ];

  @override
  DataRow? getRow(int index) {
    final grupo = grupos[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(grupo.nombre!)),
      DataCell(Text(grupo.beneficio.toString())),
      DataCell(Row(children: [
        IconButton(
          onPressed: () {
            NavigationService.navigateTo('/grupos/${grupo.id}');
          },
          icon: const Icon(Icons.edit),
        ),
        IconButton(
            onPressed: () {
              final dialog = AlertDialog(
                  title: const Text('Estas seguro de borrarlo?'),
                  content: Text('Borrar grupo $grupo.nombre?'),
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
                          var confirmado = await Provider.of<GrupoProvider>(
                                  context,
                                  listen: false)
                              .eliminar(grupo.id!);
                          if (confirmado) {
                            NotificationService.showSnackbar(
                                'Grupo eliminado exitosamente');
                          } else {
                            NotificationService.showSnackbar(
                                'Grupo no ha sido eliminado');
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
  int get rowCount => grupos.length;

  @override
  int get selectedRowCount => 0;
}
