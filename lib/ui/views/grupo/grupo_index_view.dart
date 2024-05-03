import 'package:agenda_front/providers.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/ui/views/grupo/grupo_datasource.dart';
import 'package:agenda_front/ui/widgets/elevated_button.dart';
import 'package:agenda_front/ui/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GrupoIndexView extends StatefulWidget {
  const GrupoIndexView({super.key});

  @override
  State<GrupoIndexView> createState() => _GrupoIndexViewState();
}

class _GrupoIndexViewState extends State<GrupoIndexView> {
  @override
  void initState() {
    Provider.of<GrupoProvider>(context, listen: false).buscarTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<GrupoProvider>(context).grupos;
    return Index(
      title: 'Grupos',
      columns: GrupoDataSource.columns,
      source: GrupoDataSource(data, context),
      actions: [
        EButton.create(
            onPressed: () =>
                NavigationService.navigateTo(RouterService.gruposCreateRoute))
      ],
    );
  }
}
