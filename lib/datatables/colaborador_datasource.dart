// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/models/entities/colaborador.dart';
import 'package:agenda_front/providers/colaborador_provider.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/services/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColaboradorDataSource extends DataTableSource {
  final List<Colaborador> colaboradores;
  final BuildContext context;

  ColaboradorDataSource(this.colaboradores, this.context);

  @override
  DataRow? getRow(int index) {
    final colaborador = colaboradores[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(colaborador.nombre!)),
      DataCell(Text(colaborador.profesion!)),
      DataCell(Text(colaborador.registroContribuyente!)),
      DataCell(Text(colaborador.registroProfesional!)),
      DataCell(Row(children: [
        IconButton(
          onPressed: () {
            NavigationService.navigateTo('/colaboradores/${colaborador.id}');
          },
          icon: Icon(Icons.edit),
        ),
        IconButton(
            onPressed: () {
              final dialog = AlertDialog(
                  title: Text('Estas seguro de borrarlo?'),
                  content: Text('Borrar definitivamente $colaborador.nombre?'),
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
                          var confirmado =
                              await Provider.of<ColaboradorProvider>(context,
                                      listen: false)
                                  .eliminar(colaborador.id!);
                          if (confirmado) {
                            NotificationsService.showSnackbar(
                                'Colaborador eliminado exitosamente');
                          } else {
                            NotificationsService.showSnackbar(
                                'Colaborador no ha sido eliminado');
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
  int get rowCount => colaboradores.length;

  @override
  int get selectedRowCount => 0;
}
