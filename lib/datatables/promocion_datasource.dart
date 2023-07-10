// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/models/entities/promocion.dart';
import 'package:agenda_front/providers/promocion_provider.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/services/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromocionDataSource extends DataTableSource {
  final List<Promocion> promocions;
  final BuildContext context;

  PromocionDataSource(this.promocions, this.context);

  @override
  DataRow? getRow(int index) {
    final promocion = promocions[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(promocion.nombre!)),
      DataCell(Text(promocion.tipoDescuento.toString().toUpperCase())),
      DataCell(Row(children: [
        IconButton(
          onPressed: () {
            NavigationService.navigateTo(
                '/dashboard/promocions/${promocion.id}');
          },
          icon: Icon(Icons.edit),
        ),
        IconButton(
            onPressed: () {
              final dialog = AlertDialog(
                  title: Text('Estas seguro de borrarlo?'),
                  content: Text(
                      'Borrar definitivamente promocion de $promocion.nombre?'),
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
                          var confirmado = await Provider.of<PromocionProvider>(
                                  context,
                                  listen: false)
                              .eliminar(promocion.id!);
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
  int get rowCount => promocions.length;

  @override
  int get selectedRowCount => 0;
}
