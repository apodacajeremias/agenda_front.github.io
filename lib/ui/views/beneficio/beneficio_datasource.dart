import 'package:agenda_front/providers.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/entities/beneficio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BeneficioDataSource extends DataTableSource {
  final List<Beneficio> beneficios;
  final BuildContext context;

  BeneficioDataSource(this.beneficios, this.context);

  static List<DataColumn> columns = [
    const DataColumn(label: Text('Beneficio')),
    const DataColumn(label: Text('Tipo')),
    const DataColumn(label: Text('Descuento')),
    const DataColumn(label: Text('Valor')),
    const DataColumn(label: Text('Acciones')),
  ];

  @override
  DataRow? getRow(int index) {
    final beneficio = beneficios[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(beneficio.nombre)),
      DataCell(Text(beneficio.tipo.toString())),
      DataCell(Text(beneficio.tipoDescuento.toString())),
      DataCell(Text(beneficio.descuento.toString())),
      DataCell(Row(children: [
        IconButton(
          onPressed: () {
            NavigationService.navigateTo('/beneficios/${beneficio.id}');
          },
          icon: const Icon(Icons.edit),
        ),
        IconButton(
            onPressed: () {
              final dialog = AlertDialog(
                  title: const Text('Estas seguro de borrarlo?'),
                  content: Text('Borrar beneficio $beneficio.nombre?'),
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
                          var confirmado = await Provider.of<BeneficioProvider>(
                                  context,
                                  listen: false)
                              .eliminar(beneficio.id);
                          if (confirmado) {
                            NotificationService.showSnackbar(
                                'Beneficio eliminado exitosamente');
                          } else {
                            NotificationService.showSnackbar(
                                'Beneficio no ha sido eliminado');
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
  int get rowCount => beneficios.length;

  @override
  int get selectedRowCount => 0;
}
