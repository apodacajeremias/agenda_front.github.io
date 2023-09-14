import 'package:agenda_front/datasources/agenda_datasource.dart';
import 'package:agenda_front/models/entities/agenda.dart';
import 'package:agenda_front/providers/agenda_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/ui/buttons/my_elevated_button.dart';
import 'package:agenda_front/ui/shared/indexs/my_index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgendaIndexView extends StatefulWidget {
  final List<Agenda>? data;
  const AgendaIndexView({super.key, this.data});

  @override
  State<AgendaIndexView> createState() => _AgendaIndexViewState();
}

class _AgendaIndexViewState extends State<AgendaIndexView> {
  @override
  void initState() {
    widget.data ??
        Provider.of<AgendaProvider>(context, listen: false).buscarTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data ?? Provider.of<AgendaProvider>(context).agendas;
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
