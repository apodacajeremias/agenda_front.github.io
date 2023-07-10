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
      DataCell(Text(beneficio.tipo.toString().toUpperCase())),
      DataCell(Text(beneficio.tipoDescuento.toString().toUpperCase())),
      DataCell(Text(beneficio.descuento!.toString())),
      DataCell(Text(beneficio.promociones!.length as String)),
      DataCell(Row(children: [
        IconButton(
          onPressed: () {
            NavigationService.navigateTo(
                '/dashboard/beneficios/${beneficio.id}');
          },
          icon: Icon(Icons.edit),
        ),
        IconButton(
            onPressed: () {
              final dialog = AlertDialog(
                  title: Text('Estas seguro de borrarlo?'),
                  content: Text(
                      'Borrar definitivamente beneficio de $beneficio.nombre?'),
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
  int get rowCount => beneficios.length;

  @override
  int get selectedRowCount => 0;
}
