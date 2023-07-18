import 'package:agenda_front/datatables/transaccion_datasource.dart';
import 'package:agenda_front/providers/transaccion_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agenda_front/ui/buttons/custom_icon_button.dart';
import 'package:agenda_front/ui/labels/custom_labels.dart';

class TransaccionIndexView extends StatefulWidget {
  const TransaccionIndexView({super.key});

  @override
  State<TransaccionIndexView> createState() => _TransaccionIndexViewState();
}

class _TransaccionIndexViewState extends State<TransaccionIndexView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<TransaccionProvider>(context, listen: false).buscarTodos();
  }

  @override
  Widget build(BuildContext context) {
    final transacciones = Provider.of<TransaccionProvider>(context).transacciones;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Listado de transacciones', style: CustomLabels.h1),
          const SizedBox(height: 10),
          PaginatedDataTable(
            columns: const [
              DataColumn(label: Text('Persona')),
              DataColumn(label: Text('Fecha')),
              DataColumn(label: Text('Tipo')),
              DataColumn(label: Text('Total')),
              DataColumn(label: Text('Acciones')),
            ],
            source: TransaccionDataSource(transacciones, context),
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
                      Flurorouter.transaccionesCreateRoute);
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
