// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/models/entities/beneficio.dart';
import 'package:agenda_front/providers/beneficio_provider.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/services/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BeneficioDataSource extends DataTableSource {
  final List<Beneficio> beneficios;
  final BuildContext context;

  BeneficioDataSource(this.beneficios, this.context);

  @override
  DataRow? getRow(int index) {
    final beneficio = beneficios[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(beneficio.nombre!)),
      DataCell(Text(beneficio.tipo.toString())),
      DataCell(Text(beneficio.tipoDescuento.toString())),
      DataCell(Text(beneficio.descuento.toString())),
      DataCell(Row(children: [
        IconButton(
          onPressed: () {
            NavigationService.navigateTo('/beneficios/${beneficio.id}');
          },
          icon: Icon(Icons.edit),
        ),
        IconButton(
            onPressed: () {
              final dialog = AlertDialog(
                  title: Text('Estas seguro de borrarlo?'),
                  content: Text('Borrar beneficio $beneficio.nombre?'),
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
                          var confirmado = await Provider.of<BeneficioProvider>(
                                  context,
                                  listen: false)
                              .eliminar(beneficio.id!);
                          if (confirmado) {
                            NotificationsService.showSnackbar(
                                'Beneficio eliminado exitosamente');
                          } else {
                            NotificationsService.showSnackbar(
                                'Beneficio no ha sido eliminado');
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
  int get rowCount => beneficios.length;

  @override
  int get selectedRowCount => 0;
}
