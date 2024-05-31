import 'package:agenda_front/constants.dart';
import 'package:agenda_front/providers.dart';
import 'package:agenda_front/src/models/entities/grupo.dart';
import 'package:agenda_front/ui/custom_inputs.dart';
import 'package:agenda_front/ui/widgets/elevated_button.dart';
import 'package:agenda_front/ui/widgets/form_header.dart';
import 'package:agenda_front/ui/widgets/text_separator.dart';
import 'package:agenda_front/ui/widgets/white_card.dart';
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
      padding: const EdgeInsets.all(defaultSizing),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const FormHeader(title: 'Grupo'),
          WhiteCard(
            child: FormBuilder(
              key: provider.formKey,
              child: Column(
                children: [
                  if (widget.grupo?.id != null) ...[
                    const SizedBox(height: defaultSizing),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: FormBuilderTextField(
                              name: 'ID',
                              initialValue: widget.grupo?.id,
                              enabled: false,
                              decoration: CustomInputs.form(
                                  label: 'ID', hint: 'ID', icon: Icons.qr_code),
                            )),
                        const SizedBox(width: defaultSizing),
                        Expanded(
                            child: FormBuilderSwitch(
                          name: 'activo',
                          title: const Text('Estado del registro'),
                          initialValue: widget.grupo?.activo,
                          decoration: CustomInputs.noBorder(),
                        )),
                      ],
                    )
                  ],
                  const SizedBox(height: defaultSizing),
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
                  const SizedBox(height: defaultSizing),
                  FormBuilderSearchableDropdown(
                      name: 'beneficio',
                      compareFn: (item1, item2) =>
                          item1.id.contains(item2.id),
                      items: beneficios),
                  const TextSeparator(text: 'Agregar personas al grupo'),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: FormBuilderSearchableDropdown(
                            name: 'personas-x',
                            compareFn: (item1, item2) =>
                                item1.id.contains(item2.id),
                            items: personas),
                      ),
                      const SizedBox(width: defaultSizing),
                      const Expanded(
                          child: EButton(
                        text: 'Agregar persona al grupo',
                        icon: Icons.person_add,
                      ))
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
