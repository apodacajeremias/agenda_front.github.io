// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:agenda_front/models/enums/prioridad.dart';
import 'package:agenda_front/models/enums/situacion.dart';
import 'package:agenda_front/providers/agenda_provider.dart';
import 'package:agenda_front/providers/colaborador_provider.dart';
import 'package:agenda_front/providers/persona_provider.dart';
import 'package:agenda_front/ui/buttons/link_text.dart';
import 'package:agenda_front/ui/cards/white_card.dart';
import 'package:agenda_front/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AgendaFormView extends StatefulWidget {
  const AgendaFormView({super.key});

  State<AgendaFormView> createState() => _AgendaFormViewState();
}

class _AgendaFormViewState extends State<AgendaFormView> {
  @override
  void initState() {
    Provider.of<PersonaProvider>(context, listen: false).buscarTodos();
    Provider.of<ColaboradorProvider>(context, listen: false).buscarTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AgendaProvider>(context, listen: false);
    final personas =
        Provider.of<PersonaProvider>(context, listen: false).personas;
    final colaboradores =
        Provider.of<ColaboradorProvider>(context, listen: false).colaboradores;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Agendar',
                style: CustomLabels.h1,
              ),
              LinkText(
                  text: 'Volver',
                  color: Colors.blue.withOpacity(0.4),
                  onPressed: () => Navigator.of(context).pop())
            ],
          ),
          WhiteCard(
              child: FormBuilder(
                  key: provider.formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      FormBuilderDropdown(
                        name: 'situacion',
                        items: Situacion.values
                            .map((e) => DropdownMenuItem(
                                child:
                                    Text(toBeginningOfSentenceCase(e.name)!)))
                            .toList(),
                      ),
                      SizedBox(height: 10),
                      FormBuilderDropdown(
                        name: 'prioridad',
                        items: Prioridad.values
                            .map((e) => DropdownMenuItem(
                                child:
                                    Text(toBeginningOfSentenceCase(e.name)!)))
                            .toList(),
                      ),
                    ],
                  )))
        ],
      ),
    );
  }
}
