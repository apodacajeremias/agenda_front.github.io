// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/models/entities/item.dart';
import 'package:agenda_front/providers/item_provider.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/services/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemDataSource extends DataTableSource {
  final List<Item> items;
  final BuildContext context;

  ItemDataSource(this.items, this.context);

  @override
  DataRow? getRow(int index) {
    final item = items[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(item.nombre!)),
      DataCell(Text(item.tipo.toString().toUpperCase())),
      DataCell(Text(item.precio as String)),
      DataCell(Text(item.activo as String)),
      DataCell(Row(children: [
        IconButton(
          onPressed: () {
            NavigationService.navigateTo('/dashboard/items/${item.id}');
          },
          icon: Icon(Icons.edit),
        ),
        IconButton(
            onPressed: () {
              final dialog = AlertDialog(
                  title: Text('Estas seguro de borrarlo?'),
                  content: Text('Borrar definitivamente item de $item.nombre?'),
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
                          var confirmado = await Provider.of<ItemProvider>(
                                  context,
                                  listen: false)
                              .eliminar(item.id!);
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
  int get rowCount => items.length;

  @override
  int get selectedRowCount => 0;
}
