import 'package:agenda_front/providers.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/entities/persona.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonaDataSource extends DataTableSource {
  final List<Persona> personas;
  final BuildContext context;

  PersonaDataSource(this.personas, this.context);

  static List<DataColumn> columns = const [
    DataColumn(label: Text('Nombre')),
    DataColumn(label: Text('Documento')),
    DataColumn(label: Text('Contacto')),
    DataColumn(label: Text('Acciones')),
  ];

  @override
  DataRow? getRow(int index) {
    final persona = personas[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(persona.nombre)),
      DataCell(Text(persona.documentoIdentidad)),
      DataCell(Text(persona.celular ?? persona.telefono ?? 'Sin contacto.')),
      DataCell(Row(children: [
        IconButton(
            onPressed: () {
              NavigationService.navigateTo('/personas/${persona.id}');
            },
            icon: const Icon(Icons.edit)),
        IconButton(
            onPressed: () {
              final dialog = AlertDialog(
                  title: const Text('Estas seguro de borrarlo?'),
                  content: Text('Borrar persona $persona.nombre ?'),
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
                          var confirmado = await Provider.of<PersonaProvider>(
                                  context,
                                  listen: false)
                              .eliminar(persona.id);
                          if (confirmado) {
                            NotificationService.showSnackbar(
                                'Persona eliminada exitosamente');
                          } else {
                            NotificationService.showSnackbar(
                                'Persona no ha sido eliminada');
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
  int get rowCount => personas.length;

  @override
  int get selectedRowCount => 0;
}
