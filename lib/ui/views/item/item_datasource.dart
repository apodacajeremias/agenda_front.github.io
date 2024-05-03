import 'package:agenda_front/providers.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/entities/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemDataSource extends DataTableSource {
  final List<Item> items;
  final BuildContext context;

  ItemDataSource(this.items, this.context);

  static List<DataColumn> columns = const [
    DataColumn(label: Text('Item')),
    DataColumn(label: Text('Tipo')),
    DataColumn(label: Text('Precio')),
    DataColumn(label: Text('Acciones')),
  ];

  @override
  DataRow? getRow(int index) {
    final item = items[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(item.nombre!)),
      DataCell(Text(item.tipo!.name)),
      // DataCell(TextCurrency(item.precio!)),
      DataCell(Row(children: [
        IconButton(
          onPressed: () {
            NavigationService.navigateTo('/items/${item.id}');
          },
          icon: const Icon(Icons.edit),
        ),
        IconButton(
            onPressed: () {
              final dialog = AlertDialog(
                  title: const Text('Estas seguro de borrarlo?'),
                  content: Text('Borrar item $item.nombre'),
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
                          var confirmado = await Provider.of<ItemProvider>(
                                  context,
                                  listen: false)
                              .eliminar(item.id!);
                          if (confirmado) {
                            NotificationService.showSnackbar(
                                'Item eliminado exitosamente');
                          } else {
                            NotificationService.showSnackbar(
                                'Item no ha sido eliminado');
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
  int get rowCount => items.length;

  @override
  int get selectedRowCount => 0;
}
