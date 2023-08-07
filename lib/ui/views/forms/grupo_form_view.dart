// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/models/entities/grupo.dart';
import 'package:agenda_front/providers/beneficio_provider.dart';
import 'package:agenda_front/providers/grupo_provider.dart';
import 'package:agenda_front/providers/persona_provider.dart';
import 'package:agenda_front/ui/buttons/custom_icon_button.dart';
import 'package:agenda_front/ui/cards/white_card.dart';
import 'package:agenda_front/ui/inputs/custom_inputs.dart';
import 'package:agenda_front/ui/shared/forms/form_header.dart';
import 'package:agenda_front/ui/shared/widgets/text_separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class GrupoFormView extends StatefulWidget {
  final Grupo? grupo;
  const GrupoFormView({super.key, this.grupo});

  @override
  State<GrupoFormView> createState() => _GrupoFormViewState();
}

class _GrupoFormViewState extends State<GrupoFormView> {
  @override
  void initState() {
    Provider.of<BeneficioProvider>(context, listen: false).buscarTodos();
    Provider.of<PersonaProvider>(context, listen: false).buscarTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GrupoProvider>(context, listen: false);
    final beneficios =
        Provider.of<BeneficioProvider>(context, listen: false).beneficios;
    final personas =
        Provider.of<PersonaProvider>(context, listen: false).personas;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          FormHeader(title: 'Grupo'),
          WhiteCard(
            title: 'Configurar grupo',
            child: FormBuilder(
              key: provider.formKey,
              child: Column(
                children: [
                  if (widget.grupo?.id != null) ...[
                    Row(
                      children: [
                        Expanded(
                            child: FormBuilderTextField(
                          name: 'id',
                          initialValue: widget.grupo?.id,
                          enabled: false,
                          decoration: CustomInputs.form(
                              label: 'ID', hint: 'ID', icon: Icons.qr_code),
                        )),
                        SizedBox(width: 10),
                        Expanded(
                            child: FormBuilderSwitch(
                                name: 'activo',
                                title: Text(
                                  'Estado del registro'
                                ),
                                initialValue: widget.grupo?.activo,
                                decoration: CustomInputs.noBorder()))
                      ],
                    ),
                  ],
                  SizedBox(height: 10),
                  FormBuilderTextField(
                      name: 'nombre',
                      initialValue: widget.grupo?.nombre,
                      enabled: widget.grupo?.activo ?? true,
                      decoration: CustomInputs.form(
                          label: 'Nombre del grupo',
                          hint: 'Nombre que describa al grupo',
                          icon: Icons.info),
                      validator: FormBuilderValidators.required(
                          errorText: 'Campo obligatorio')),
                  SizedBox(height: 10),
                  FormBuilderSearchableDropdown(
                      name: 'beneficio',
                      compareFn: (item1, item2) =>
                          item1.id!.contains(item2.id!),
                      items: beneficios),
                  TextSeparator(text: 'Agregar personas al grupo'),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: FormBuilderSearchableDropdown(
                            name: 'personas-x',
                            compareFn: (item1, item2) =>
                                item1.id!.contains(item2.id!),
                            items: personas),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CustomIconButton(
                            onPressed: () {
                              // agregar persona a la lista
                            },
                            text: 'Agregar',
                            icon: Icons.add),
                      )
                    ],
                  ),
                  // TODO: agregar una tabla que muestre los integrantes del grupo
                  // TODO: la tabla debe poseer un boton para quitar a los integrantes de grupo

                  
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
