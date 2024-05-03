import 'package:agenda_front/providers.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/ui/views/colaborador/colaborador_datasource.dart';
import 'package:agenda_front/ui/widgets/elevated_button.dart';
import 'package:agenda_front/ui/widgets/index.dart';
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
    return Index(
      title: 'Colaboradores',
      columns: ColaboradorDataSource.columns,
      source: ColaboradorDataSource(data, context),
      actions: [
        EButton.create(
            onPressed: () => NavigationService.navigateTo(
                RouterService.colaboradoresCreateRoute))
      ],
    );
  }
}
