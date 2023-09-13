import 'package:agenda_front/datasources/item_datasource.dart';
import 'package:agenda_front/providers/item_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/ui/buttons/my_elevated_button.dart';
import 'package:agenda_front/ui/shared/indexs/my_index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemIndexView extends StatefulWidget {
  const ItemIndexView({super.key});

  @override
  State<ItemIndexView> createState() => _ItemIndexViewState();
}

class _ItemIndexViewState extends State<ItemIndexView> {
  @override
  void initState() {
    Provider.of<ItemProvider>(context, listen: false).buscarTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ItemProvider>(context).items;
    return MyIndex(
      title: 'Items',
      columns: ItemDataSource.columns,
      source: ItemDataSource(data, context),
      actions: [
        MyElevatedButton.create(
            onPressed: () =>
                NavigationService.navigateTo(Flurorouter.itemsCreateRoute))
      ],
    );
  }
}
