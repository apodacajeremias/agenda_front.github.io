import 'package:agenda_front/extensions.dart';
import 'package:agenda_front/providers.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/entities/promocion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromocionDataSource extends DataTableSource {
  final List<Promocion> promociones;
  final BuildContext context;

  PromocionDataSource(this.promociones, this.context);

  static List<DataColumn> columns = const [
    DataColumn(label: Text('Promoción')),
    DataColumn(label: Text('Inicio')),
    DataColumn(label: Text('Fin')),
    DataColumn(label: Text('Valor')),
    DataColumn(label: Text('Acciones')),
  ];

  @override
  DataRow? getRow(int index) {
    final promocion = promociones[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(promocion.nombre)),
      DataCell(Text(promocion.inicio.formatDate())),
      DataCell(Text(promocion.fin.formatDate())),
      DataCell(Text(promocion.valor.toString())),
      DataCell(Row(children: [
        IconButton(
          onPressed: () {
            NavigationService.navigateTo('/promociones/${promocion.id}');
          },
          icon: const Icon(Icons.edit),
        ),
        IconButton(
            onPressed: () {
              final dialog = AlertDialog(
                  title: const Text('Estas seguro de borrarlo?'),
                  content: Text('Borrar promocion $promocion.nombre?'),
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
                          var confirmado = await Provider.of<PromocionProvider>(
                                  context,
                                  listen: false)
                              .eliminar(promocion.id);
                          if (confirmado) {
                            NotificationService.showSnackbar(
                                'Promocion eliminada exitosamente');
                          } else {
                            NotificationService.showSnackbar(
                                'Promocino no ha sido eliminada');
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
  int get rowCount => promociones.length;

  @override
  int get selectedRowCount => 0;
}
