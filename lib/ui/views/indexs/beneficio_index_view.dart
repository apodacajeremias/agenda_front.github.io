import 'package:agenda_front/datatables/beneficio_datasource.dart';
import 'package:agenda_front/providers/beneficio_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agenda_front/ui/buttons/custom_icon_button.dart';
import 'package:agenda_front/ui/labels/custom_labels.dart';

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
          Text('Listado de beneficios', style: CustomLabels.h1),
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
                      Flurorouter.beneficiosCreateRoute);
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
