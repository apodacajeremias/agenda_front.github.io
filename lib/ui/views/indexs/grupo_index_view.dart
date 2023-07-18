import 'package:agenda_front/datatables/grupo_datasource.dart';
import 'package:agenda_front/providers/grupo_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agenda_front/ui/buttons/custom_icon_button.dart';
import 'package:agenda_front/ui/labels/custom_labels.dart';

class GrupoIndexView extends StatefulWidget {
  const GrupoIndexView({super.key});

  @override
  State<GrupoIndexView> createState() => _GrupoIndexViewState();
}

class _GrupoIndexViewState extends State<GrupoIndexView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<GrupoProvider>(context, listen: false).buscarTodos();
  }

  @override
  Widget build(BuildContext context) {
    final grupos = Provider.of<GrupoProvider>(context).grupos;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Listado de grupos', style: CustomLabels.h1),
          const SizedBox(height: 10),
          PaginatedDataTable(
            columns: const [
              DataColumn(label: Text('Grupo')),
              DataColumn(label: Text('Beneficio')),
              DataColumn(label: Text('Acciones')),
            ],
            source: GrupoDataSource(grupos, context),
            header: const Text('Registros', maxLines: 2),
            onRowsPerPageChanged: (value) {
              setState(() {
                _rowsPerPage = value ?? 10;
              });
            },
            rowsPerPage: _rowsPerPage,
            actions: [
              CustomIconButton(
                onPressed: () {
                  NavigationService.navigateTo(
                      Flurorouter.gruposCreateRoute);
                },
                text: 'Nuevo',
                icon: Icons.add_outlined,
              )
            ],
          )
        ],
      ),
    );
  }
}
