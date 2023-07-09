import 'package:agenda_front/datatables/personas_datasource.dart';
import 'package:agenda_front/providers/persona_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agenda_front/ui/buttons/custom_icon_button.dart';
import 'package:agenda_front/ui/labels/custom_labels.dart';

class PersonaIndexView extends StatefulWidget {
  const PersonaIndexView({super.key});

  @override
  State<PersonaIndexView> createState() => _PersonaIndexViewState();
}

class _PersonaIndexViewState extends State<PersonaIndexView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<PersonaProvider>(context, listen: false).buscarTodos();
  }

  @override
  Widget build(BuildContext context) {
    final personas = Provider.of<PersonaProvider>(context).personas;
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
            source: PersonaDataSource(personas, context),
            header: const Text('Personas registradas', maxLines: 2),
            onRowsPerPageChanged: (value) {
              setState(() {
                _rowsPerPage = value ?? 10;
              });
            },
            rowsPerPage: _rowsPerPage,
            actions: [
              CustomIconButton(
                onPressed: () {
                  NavigationService.navigateTo(Flurorouter.personasCreateRoute);
                },
                text: 'Crear',
                icon: Icons.add_outlined,
              )
            ],
          )
        ],
      ),
    );
  }
}
