// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/models/persona.dart';
import 'package:agenda_front/providers/persona_provider.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonasDataSource extends DataTableSource {
  final List<Persona> personas;
  final BuildContext context;

  PersonasDataSource(this.personas, this.context);

  @override
  DataRow? getRow(int index) {
    final persona = personas[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(persona.nombre!)),
      DataCell(Text(persona.documentoIdentidad!)),
      DataCell(Text(persona.genero!)),
      DataCell(Text(persona.celular ?? persona.telefono ?? '')),
      DataCell(Row(
        children: [
          IconButton(
              onPressed: () {
                NavigationService.replaceTo(
                    '/dashboard/personas/${persona.id}');
              },
              icon: Icon(Icons.edit_outlined)),
          IconButton(
              onPressed: () {
                final dialog = AlertDialog(
                  title: Text('Estas seguro de borrarlo?'),
                  content: Text('Borrar definitivamente $persona.nombre ?'),
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
                        await Provider.of<PersonaProvider>(context,
                                listen: false)
                            .deletePersona(persona.id!);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
                showDialog(context: context, builder: (_) => dialog);
              },
              icon: Icon(Icons.delete_outlined),
              color: Colors.red.withOpacity(0.8))
        ],
      ))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => personas.length;

  @override
  int get selectedRowCount => 0;
}
