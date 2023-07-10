// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/models/entities/empresa.dart';
import 'package:agenda_front/providers/empresa_provider.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/services/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmpresaDataSource extends DataTableSource {
  final List<Empresa> empresas;
  final BuildContext context;

  EmpresaDataSource(this.empresas, this.context);

  @override
  DataRow? getRow(int index) {
    final empresa = empresas[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(empresa.nombre!)),
      DataCell(Text(empresa.idioma.toString().toUpperCase())),
      DataCell(Text(empresa.moneda.toString().toUpperCase())),
      DataCell(Row(children: [
        IconButton(
          onPressed: () {
            NavigationService.navigateTo(
                '/dashboard/empresas/${empresa.id}');
          },
          icon: Icon(Icons.edit),
        ),
        IconButton(
            onPressed: () {
              final dialog = AlertDialog(
                  title: Text('Estas seguro de borrarlo?'),
                  content: Text(
                      'Borrar definitivamente empresa de $empresa.nombre?'),
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
                          var confirmado = await Provider.of<EmpresaProvider>(
                                  context,
                                  listen: false)
                              .eliminar(empresa.id!);
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
  int get rowCount => empresas.length;

  @override
  int get selectedRowCount => 0;
}
