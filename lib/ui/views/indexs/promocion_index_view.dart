import 'package:agenda_front/constants.dart';
import 'package:agenda_front/datasources/promocion_datasource.dart';
import 'package:agenda_front/providers/promocion_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/ui/shared/indexs/index_footer.dart';
import 'package:agenda_front/ui/shared/indexs/index_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agenda_front/ui/buttons/my_elevated_button.dart';

class PromocionIndexView extends StatefulWidget {
  const PromocionIndexView({super.key});

  @override
  State<PromocionIndexView> createState() => _PromocionIndexViewState();
}

class _PromocionIndexViewState extends State<PromocionIndexView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<PromocionProvider>(context, listen: false).buscarTodos();
  }

  @override
  Widget build(BuildContext context) {
    final promociones = Provider.of<PromocionProvider>(context).promociones;
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const IndexHeader(title: 'Promociones'),
          const SizedBox(height: defaultPadding),
          PaginatedDataTable(
            columns: const [
              DataColumn(label: Text('Promocion')),
              DataColumn(label: Text('Inicio')),
              DataColumn(label: Text('Fin')),
              DataColumn(label: Text('Valor')),
              DataColumn(label: Text('Acciones')),
            ],
            source: PromocionDataSource(promociones, context),
            header: const Text('Listado de promociones', maxLines: 2),
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
                      Flurorouter.promocionesCreateRoute);
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
