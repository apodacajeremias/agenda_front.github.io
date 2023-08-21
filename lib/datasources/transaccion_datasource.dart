// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/models/entities/transaccion.dart';
import 'package:agenda_front/providers/transaccion_provider.dart';
import 'package:agenda_front/utils/fecha_util.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/services/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransaccionDataSource extends DataTableSource {
  final List<Transaccion> transacciones;
  final BuildContext context;

  TransaccionDataSource(this.transacciones, this.context);

  @override
  DataRow? getRow(int index) {
    final transaccion = transacciones[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(transaccion.persona!.nombre!)),
      DataCell(Text(FechaUtil.formatDate(transaccion.fechaCreacion!))),
      DataCell(Text(transaccion.tipo.toString())),
      DataCell(Text(transaccion.total.toString())),
      DataCell(Row(children: [
        IconButton(
          onPressed: () {
            NavigationService.navigateTo('/transacciones/${transaccion.id}');
          },
          icon: Icon(Icons.edit),
        ),
        IconButton(
            onPressed: () {
              final dialog = AlertDialog(
                  title: Text('Estas seguro de borrarlo?'),
                  content: Text('Borrar transaccion $transaccion.nombre?'),
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
                              await Provider.of<TransaccionProvider>(context,
                                      listen: false)
                                  .eliminar(transaccion.id!);
                          if (confirmado) {
                            NotificationsService.showSnackbar(
                                'Transaccion eliminada exitosamente');
                          } else {
                            NotificationsService.showSnackbar(
                                'Transaccion no ha sido eliminada');
                          }
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        }),
                  ]);
              showDialog(context: context, builder: (_) => dialog);
            },
            icon: Icon(Icons.delete))
      ]))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => transacciones.length;

  @override
  int get selectedRowCount => 0;
}
