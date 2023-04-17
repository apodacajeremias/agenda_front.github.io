// ignore_for_file: library_private_types_in_public_api

import 'package:agenda_front/datatables/personas_datasource.dart';
import 'package:agenda_front/providers/personas_provider.dart';
import 'package:agenda_front/ui/modals/persona_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agenda_front/ui/buttons/custom_icon_button.dart';
import 'package:agenda_front/ui/labels/custom_labels.dart';

class PersonasView extends StatefulWidget {
  const PersonasView({super.key});

  @override
  _PersonasViewState createState() => _PersonasViewState();
}

class _PersonasViewState extends State<PersonasView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<PersonasProvider>(context, listen: false).getPersonas();
  }

  @override
  Widget build(BuildContext context) {
    final personas = Provider.of<PersonasProvider>(context).personas;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Personas', style: CustomLabels.h1),
          const SizedBox(height: 10),
          PaginatedDataTable(
            columns: const [
              DataColumn(label: Text('Nombre')),
              DataColumn(label: Text('Documento')),
              DataColumn(label: Text('Genero')),
              DataColumn(label: Text('Contacto')),
              DataColumn(label: Text('Acciones')),
            ],
            source: PersonasDataSource(personas, context),
            header: const Text('Personas registradas', maxLines: 2),
            onRowsPerPageChanged: (value) {
              setState(() {
                _rowsPerPage = value ?? 10;
              });
            },
            rowsPerPage: _rowsPerPage,
            actions: [
              // CustomIconButton(
              //   onPressed: () {
              //     showModalBottomSheet(
              //         backgroundColor: Colors.transparent,
              //         context: context,
              //         builder: (_) => const PersonasModal(persona: null));
              //   },
              //   text: 'Crear',
              //   icon: Icons.add_outlined,
              // )
            ],
          )
        ],
      ),
    );
  }
}
