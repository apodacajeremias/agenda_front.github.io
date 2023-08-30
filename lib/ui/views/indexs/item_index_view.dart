import 'package:agenda_front/constants.dart';
import 'package:agenda_front/datasources/item_datasource.dart';
import 'package:agenda_front/providers/item_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/ui/shared/indexs/index_footer.dart';
import 'package:agenda_front/ui/shared/indexs/index_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agenda_front/ui/buttons/my_elevated_button.dart';

class ItemIndexView extends StatefulWidget {
  const ItemIndexView({super.key});

  @override
  State<ItemIndexView> createState() => _ItemIndexViewState();
}

class _ItemIndexViewState extends State<ItemIndexView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<ItemProvider>(context, listen: false).buscarTodos();
  }

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<ItemProvider>(context).items;
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const IndexHeader(title: 'Items'),
          const SizedBox(height: defaultPadding),
          PaginatedDataTable(
            columns: const [
              DataColumn(label: Text('Item')),
              DataColumn(label: Text('Tipo')),
              DataColumn(label: Text('Precio')),
              DataColumn(label: Text('Acciones')),
            ],
            source: ItemDataSource(items, context),
            header: const Text('Listado de items', maxLines: 2),
            onRowsPerPageChanged: (value) {
              setState(() {
                _rowsPerPage = value ?? 10;
              });
            },
            rowsPerPage: _rowsPerPage,
            actions: [
              MyElevatedButton(
                onPressed: () {
                  NavigationService.navigateTo(Flurorouter.itemsCreateRoute);
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
