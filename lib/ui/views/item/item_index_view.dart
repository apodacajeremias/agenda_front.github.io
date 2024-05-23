import 'package:agenda_front/providers.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/ui/views/item/item_datasource.dart';
import 'package:agenda_front/ui/widgets/elevated_button.dart';
import 'package:agenda_front/ui/widgets/index.dart';
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
    return Index(
      title: 'Items',
      columns: ItemDataSource.columns,
      source: ItemDataSource(data, context),
      actions: [
        EButton.registrar(
            onPressed: () =>
                NavigationService.navigateTo(RouterService.itemsCreateRoute))
      ],
    );
  }
}
