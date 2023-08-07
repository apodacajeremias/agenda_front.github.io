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
      DataCell(Text(item.tipo!.name)),
      DataCell(Text(item.precio.toString())),
      DataCell(Row(children: [
        IconButton(
          onPressed: () {
            NavigationService.navigateTo('/items/${item.id}');
          },
          icon: Icon(Icons.edit),
        ),
        IconButton(
            onPressed: () {
              final dialog = AlertDialog(
                  title: Text('Estas seguro de borrarlo?'),
                  content: Text('Borrar item $item.nombre?'),
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
                                'Item eliminado exitosamente');
                          } else {
                            NotificationsService.showSnackbar(
                                'Item no ha sido eliminado');
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
  int get rowCount => items.length;

  @override
  int get selectedRowCount => 0;
}
