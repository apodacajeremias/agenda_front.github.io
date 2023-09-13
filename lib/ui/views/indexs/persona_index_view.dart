import 'package:agenda_front/datasources/persona_datasource.dart';
import 'package:agenda_front/providers/persona_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/ui/buttons/my_elevated_button.dart';
import 'package:agenda_front/ui/shared/indexs/my_index.dart';
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
    return MyIndex(
      title: 'Personas',
      columns: PersonaDataSource.columns,
      source: PersonaDataSource(data, context),
      actions: [
        MyElevatedButton.create(
            onPressed: () =>
                NavigationService.navigateTo(Flurorouter.personasCreateRoute))
      ],
    );
  }
}
