import 'package:agenda_front/datasources/grupo_datasource.dart';
import 'package:agenda_front/providers/grupo_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/ui/shared/indexs/my_index.dart';
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
    return MyIndex(
        title: 'Grupos',
        columns: GrupoDataSource.columns,
        source: GrupoDataSource(data, context),
        createRoute: Flurorouter.gruposCreateRoute);
  }
}
