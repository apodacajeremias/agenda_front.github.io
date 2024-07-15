import 'package:agenda_front/providers.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/entities/colaborador.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColaboradorDataSource extends DataTableSource {
  final List<Colaborador> colaboradores;
  final BuildContext context;

  ColaboradorDataSource(this.colaboradores, this.context);

  static List<DataColumn> columns = const [
    DataColumn(label: Text('Colaborador')),
    DataColumn(label: Text('Cargo')),
    DataColumn(label: Text('Registro Contribuyente')),
    DataColumn(label: Text('Registro Profesional')),
    DataColumn(label: Text('Acciones')),
  ];

  @override
  DataRow? getRow(int index) {
    final colaborador = colaboradores[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(colaborador.nombre)),
      DataCell(Text(colaborador.cargo ?? 'Sin registro.')),
      DataCell(Text(colaborador.registroContribuyente!)),
      DataCell(Text(colaborador.registroProfesional!)),
      DataCell(Row(children: [
        IconButton(
          onPressed: () {
            NavigationService.navigateTo('/colaboradores/${colaborador.id}');
          },
          icon: const Icon(Icons.edit),
        ),
        IconButton(
            onPressed: () {
              final dialog = AlertDialog(
                  title: const Text('Estas seguro de borrarlo?'),
                  content: Text('Borrar definitivamente $colaborador.nombre?'),
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
                          var confirmado =
                              await Provider.of<ColaboradorProvider>(context,
                                      listen: false)
                                  .eliminar(colaborador.id);
                          if (confirmado) {
                            NotificationService.showSnackbar(
                                'Colaborador eliminado exitosamente');
                          } else {
                            NotificationService.showSnackbar(
                                'Colaborador no ha sido eliminado');
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
  int get rowCount => colaboradores.length;

  @override
  int get selectedRowCount => 0;
}
