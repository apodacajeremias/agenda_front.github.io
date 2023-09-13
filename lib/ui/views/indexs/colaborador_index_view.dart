import 'package:agenda_front/datasources/colaborador_datasource.dart';
import 'package:agenda_front/providers/colaborador_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/ui/buttons/my_elevated_button.dart';
import 'package:agenda_front/ui/shared/indexs/my_index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColaboradorIndexView extends StatefulWidget {
  const ColaboradorIndexView({super.key});

  @override
  State<ColaboradorIndexView> createState() => _ColaboradorIndexViewState();
}

class _ColaboradorIndexViewState extends State<ColaboradorIndexView> {
  @override
  void initState() {
    Provider.of<ColaboradorProvider>(context, listen: false).buscarTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ColaboradorProvider>(context).colaboradores;
    return MyIndex(
      title: 'Colaboradores',
      columns: ColaboradorDataSource.columns,
      source: ColaboradorDataSource(data, context),
      actions: [
        MyElevatedButton.create(
            onPressed: () => NavigationService.navigateTo(
                Flurorouter.colaboradoresCreateRoute))
      ],
    );
  }
}
