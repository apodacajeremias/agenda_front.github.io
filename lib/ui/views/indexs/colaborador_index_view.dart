import 'package:agenda_front/datasources/colaborador_datasource.dart';
import 'package:agenda_front/providers/colaborador_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/ui/shared/indexs/index_footer.dart';
import 'package:agenda_front/ui/shared/indexs/index_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agenda_front/ui/buttons/my_elevated_button.dart';

class ColaboradorIndexView extends StatefulWidget {
  const ColaboradorIndexView({super.key});

  @override
  State<ColaboradorIndexView> createState() => _ColaboradorIndexViewState();
}

class _ColaboradorIndexViewState extends State<ColaboradorIndexView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<ColaboradorProvider>(context, listen: false).buscarTodos();
  }

  @override
  Widget build(BuildContext context) {
    final colaboradores =
        Provider.of<ColaboradorProvider>(context).colaboradores;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const IndexHeader(title: 'Colaboradores'),
          const SizedBox(height: 10),
          PaginatedDataTable(
            columns: const [
              DataColumn(label: Text('Colaborador')),
              DataColumn(label: Text('Profesion')),
              DataColumn(label: Text('Registro Contribuyente')),
              DataColumn(label: Text('Registro Profesional')),
              DataColumn(label: Text('Acciones')),
            ],
            source: ColaboradorDataSource(colaboradores, context),
            header: const Text('Listado de colaboradores', maxLines: 2),
            onRowsPerPageChanged: (value) {
              setState(() {
                _rowsPerPage = value ?? 10;
              });
            },
            rowsPerPage: _rowsPerPage,
            actions: [
              MyElevatedButton(
                onPressed: () {
                  NavigationService.navigateTo(
                      Flurorouter.colaboradoresCreateRoute);
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
