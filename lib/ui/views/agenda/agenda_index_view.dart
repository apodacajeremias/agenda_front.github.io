import 'package:agenda_front/providers.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/entities/agenda.dart';
import 'package:agenda_front/ui/views/agenda/agenda_datasource.dart';
import 'package:agenda_front/ui/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/index.dart';

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
        Provider.of<AgendaProvider>(context, listen: false)
            .buscarPorRango(DateTime.now(), DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data ?? Provider.of<AgendaProvider>(context).agendas;
    return Index(
      title: 'Agendas',
      columns: AgendaDataSource.columns,
      source: AgendaDataSource(data, context),
      actions: [
        EButton.registrar(
            onPressed: () =>
                NavigationService.navigateTo(RouterService.agendasCreateRoute))
      ],
    );
  }
}
