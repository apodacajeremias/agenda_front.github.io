import 'package:agenda_front/datasources/agenda_datasource.dart';
import 'package:agenda_front/providers/agenda_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/ui/buttons/my_elevated_button.dart';
import 'package:agenda_front/ui/shared/indexs/my_index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgendaIndexView extends StatefulWidget {
  const AgendaIndexView({super.key});

  @override
  State<AgendaIndexView> createState() => _AgendaIndexViewState();
}

class _AgendaIndexViewState extends State<AgendaIndexView> {
  @override
  void initState() {
    Provider.of<AgendaProvider>(context, listen: false).buscarTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AgendaProvider>(context).agendas;
    return MyIndex(
      title: 'Agendas',
      columns: AgendaDataSource.columns,
      source: AgendaDataSource(data, context),
      actions: [
        MyElevatedButton.create(
            onPressed: () =>
                NavigationService.navigateTo(Flurorouter.agendasCreateRoute))
      ],
    );
  }
}
