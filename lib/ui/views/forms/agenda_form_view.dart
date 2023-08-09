// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:agenda_front/models/enums/prioridad.dart';
import 'package:agenda_front/models/enums/situacion.dart';
import 'package:agenda_front/providers/agenda_provider.dart';
import 'package:agenda_front/providers/colaborador_provider.dart';
import 'package:agenda_front/providers/persona_provider.dart';
import 'package:agenda_front/ui/shared/forms/form_footer.dart';
import 'package:agenda_front/ui/shared/forms/form_header.dart';
import 'package:agenda_front/utils/fecha_util.dart';
import 'package:agenda_front/ui/cards/white_card.dart';
import 'package:agenda_front/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AgendaFormView extends StatefulWidget {
  const AgendaFormView({super.key});

  @override
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
          FormHeader(title: 'Agendar'),
          WhiteCard(
              child: FormBuilder(
                  key: provider.formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: FormBuilderDateTimePicker(
                                  name: 'fecha',
                                  format: FechaUtil.dateFormat,
                                  decoration: CustomInputs.form(
                                      hint: 'Fecha',
                                      label: 'Fecha',
                                      icon: Icons.event),
                                  validator: FormBuilderValidators.required(
                                      errorText: 'Campo obligatorio'),
                                  inputType: InputType.date,
                                  valueTransformer: (value) =>
                                      value?.toIso8601String())),
                          SizedBox(width: 10),
                          Expanded(
                              child: FormBuilderDateTimePicker(
                                  name: 'hora',
                                  format: FechaUtil.timeFormat,
                                  decoration: CustomInputs.form(
                                      hint: 'Hora',
                                      label: 'Hora',
                                      icon: Icons.schedule),
                                  validator: FormBuilderValidators.required(
                                      errorText: 'Campo obligatorio'),
                                  inputType: InputType.time,
                                  valueTransformer: (value) =>
                                      value?.toIso8601String())),
                        ],
                      ),
                      SizedBox(height: 10),
                      FormBuilderSearchableDropdown(
                        name: 'persona',
                        compareFn: (item1, item2) =>
                            item1.id!.contains(item2.id!),
                        items: personas,
                      ),
                      SizedBox(height: 10),
                      FormBuilderSearchableDropdown(
                        name: 'colaborador',
                        compareFn: (item1, item2) =>
                            item1.id!.contains(item2.id!),
                        items: colaboradores,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: FormBuilderDropdown(
                              name: 'situacion',
                              items: Situacion.values
                                  .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                          toBeginningOfSentenceCase(e.name)!)))
                                  .toList(),
                              validator: FormBuilderValidators.required(
                                  errorText: 'Campo obligatorio'),
                              valueTransformer: (value) => value?.name,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: FormBuilderDropdown(
                              name: 'prioridad',
                              items: Prioridad.values
                                  .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                          toBeginningOfSentenceCase(e.name)!)))
                                  .toList(),
                              validator: FormBuilderValidators.required(
                                  errorText: 'Campo obligatorio'),
                              valueTransformer: (value) => value?.name,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      FormBuilderTextField(
                        name: 'observacion',
                        decoration: CustomInputs.form(
                            label: 'Observaciones',
                            hint:
                                'Escriba sus observaciones para el agendamiento',
                            icon: Icons.notes),
                        keyboardType: TextInputType.multiline,
                        minLines: 2,
                        maxLines: 5, //
                      ),
                      SizedBox(height: 10),
                      FormFooter(onConfirm: () async {
                        if (provider.saveAndValidate()) {
                          try {
                            provider.registrar(provider.formData());
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          } catch (e) {
                            rethrow;
                          }
                        }
                      })
                    ],
                  )))
        ],
      ),
    );
  }
}
