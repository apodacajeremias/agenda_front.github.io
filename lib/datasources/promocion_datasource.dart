// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/models/entities/promocion.dart';
import 'package:agenda_front/providers/promocion_provider.dart';
import 'package:agenda_front/utils/fecha_util.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/services/notifications_service.dart';
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
      DataCell(Text(promocion.nombre!)),
      DataCell(Text(FechaUtil.formatDate(promocion.inicio!))),
      DataCell(Text(FechaUtil.formatDate(promocion.fin!))),
      DataCell(Text(promocion.valor.toString())),
      DataCell(Row(children: [
        IconButton(
          onPressed: () {
            NavigationService.navigateTo('/promociones/${promocion.id}');
          },
          icon: Icon(Icons.edit),
        ),
        IconButton(
            onPressed: () {
              final dialog = AlertDialog(
                  title: Text('Estas seguro de borrarlo?'),
                  content: Text('Borrar promocion $promocion.nombre?'),
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
                                'Promocion eliminada exitosamente');
                          } else {
                            NotificationsService.showSnackbar(
                                'Promocino no ha sido eliminada');
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
  int get rowCount => promociones.length;

  @override
  int get selectedRowCount => 0;
}
