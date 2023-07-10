// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/models/entities/grupo.dart';
import 'package:agenda_front/providers/grupo_provider.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/services/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GrupoDataSource extends DataTableSource {
  final List<Grupo> grupos;
  final BuildContext context;

  GrupoDataSource(this.grupos, this.context);

  @override
  DataRow? getRow(int index) {
    final grupo = grupos[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(grupo.nombre!)),
      DataCell(Text(grupo.beneficio!.tipo.toString().toUpperCase())),
      DataCell(Text(grupo.activo as String)),
      DataCell(Row(children: [
        IconButton(
          onPressed: () {
            NavigationService.navigateTo(
                '/dashboard/grupos/${grupo.id}');
          },
          icon: Icon(Icons.edit),
        ),
        IconButton(
            onPressed: () {
              final dialog = AlertDialog(
                  title: Text('Estas seguro de borrarlo?'),
                  content: Text(
                      'Borrar definitivamente grupo de $grupo.nombre?'),
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
                          var confirmado = await Provider.of<GrupoProvider>(
                                  context,
                                  listen: false)
                              .eliminar(grupo.id!);
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
  int get rowCount => grupos.length;

  @override
  int get selectedRowCount => 0;
}
