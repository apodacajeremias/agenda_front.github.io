import 'package:agenda_front/datasources/beneficio_datasource.dart';
import 'package:agenda_front/providers/beneficio_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/ui/shared/indexs/index_footer.dart';
import 'package:agenda_front/ui/shared/indexs/index_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agenda_front/ui/buttons/my_elevated_button.dart';

class BeneficioIndexView extends StatefulWidget {
  const BeneficioIndexView({super.key});

  @override
  State<BeneficioIndexView> createState() => _BeneficioIndexViewState();
}

class _BeneficioIndexViewState extends State<BeneficioIndexView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<BeneficioProvider>(context, listen: false).buscarTodos();
  }

  @override
  Widget build(BuildContext context) {
    final beneficios = Provider.of<BeneficioProvider>(context).beneficios;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const IndexHeader(title: 'Beneficios'),
          const SizedBox(height: 10),
          PaginatedDataTable(
            columns: const [
              DataColumn(label: Text('Beneficio')),
              DataColumn(label: Text('Tipo')),
              DataColumn(label: Text('Descuento')),
              DataColumn(label: Text('Valor')),
              DataColumn(label: Text('Acciones')),
            ],
            source: BeneficioDataSource(beneficios, context),
            header: const Text('Listado de beneficios', maxLines: 2),
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
                      Flurorouter.beneficiosCreateRoute);
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
