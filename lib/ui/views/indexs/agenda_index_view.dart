import 'package:agenda_front/datatables/agenda_datasource.dart';
import 'package:agenda_front/providers/agenda_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/ui/shared/indexs/index_footer.dart';
import 'package:agenda_front/ui/shared/indexs/index_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agenda_front/ui/buttons/custom_icon_button.dart';

class AgendaIndexView extends StatefulWidget {
  const AgendaIndexView({super.key});

  @override
  State<AgendaIndexView> createState() => _AgendaIndexViewState();
}

class _AgendaIndexViewState extends State<AgendaIndexView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<AgendaProvider>(context, listen: false).buscarTodos();
  }

  @override
  Widget build(BuildContext context) {
    final agendas = Provider.of<AgendaProvider>(context).agendas;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const IndexHeader(title: 'Agendas'),
          const SizedBox(height: 10),
          PaginatedDataTable(
            columns: const [
              DataColumn(label: Text('Persona')),
              DataColumn(label: Text('Fecha')),
              DataColumn(label: Text('Hora')),
              DataColumn(label: Text('Colaborador')),
              DataColumn(label: Text('Prioridad')),
              DataColumn(label: Text('Acciones')),
            ],
            source: AgendaDataSource(agendas, context),
            header: const Text('Listado de agendamientos', maxLines: 2),
            onRowsPerPageChanged: (value) {
              setState(() {
                _rowsPerPage = value ?? 10;
              });
            },
            rowsPerPage: _rowsPerPage,
            actions: [
              CustomIconButton(
                onPressed: () {
                  NavigationService.navigateTo(Flurorouter.agendasCreateRoute);
                },
                text: 'Nuevo',
                icon: Icons.add_outlined,
              )
            ],
            
          ),
          const IndexFooter()
        ],
      ),
    );
  }
}
