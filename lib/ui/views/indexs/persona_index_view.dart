import 'package:agenda_front/constants.dart';
import 'package:agenda_front/datasources/persona_datasource.dart';
import 'package:agenda_front/providers/persona_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/ui/shared/indexs/index_footer.dart';
import 'package:agenda_front/ui/shared/indexs/index_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agenda_front/ui/buttons/my_elevated_button.dart';

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
      padding: const EdgeInsets.all(defaultPadding),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const IndexHeader(title: 'Personas'),
          const SizedBox(height: defaultPadding),
          PaginatedDataTable(
            columns: const [
              DataColumn(label: Text('Nombre')),
              DataColumn(label: Text('Documento')),
              DataColumn(label: Text('Contacto')),
              DataColumn(label: Text('Acciones')),
            ],
            source: PersonaDataSource(personas, context),
            header: const Text('Listado de personas', maxLines: 2),
            onRowsPerPageChanged: (value) {
              setState(() {
                _rowsPerPage = value ?? 10;
              });
            },
            rowsPerPage: _rowsPerPage,
            actions: [
              MyElevatedButton(
                onPressed: () {
                  NavigationService.navigateTo(Flurorouter.personasCreateRoute);
                },
                text: 'Nuevo',
                icon: Icons.add,
              )
            ],
          ),
          const IndexFooter()
        ],
      ),
    );
  }
}
