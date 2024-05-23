import 'package:agenda_front/providers.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/ui/views/persona/persona_datasource.dart';

import 'package:agenda_front/ui/widgets/elevated_button.dart';
import 'package:agenda_front/ui/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonaIndexView extends StatefulWidget {
  const PersonaIndexView({super.key});

  @override
  State<PersonaIndexView> createState() => _PersonaIndexViewState();
}

class _PersonaIndexViewState extends State<PersonaIndexView> {
  @override
  void initState() {
    Provider.of<PersonaProvider>(context, listen: false).buscarTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<PersonaProvider>(context).personas;
    return Index(
      title: 'Personas',
      columns: PersonaDataSource.columns,
      source: PersonaDataSource(data, context),
      actions: [
        EButton.registrar(
            onPressed: () =>
                NavigationService.navigateTo(RouterService.personasCreateRoute))
      ],
    );
  }
}
