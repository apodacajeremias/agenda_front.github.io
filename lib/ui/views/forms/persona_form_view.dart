import 'package:agenda_front/models/enums/generos.dart';
import 'package:agenda_front/models/persona.dart';
import 'package:agenda_front/providers/persona_provider.dart';
import 'package:agenda_front/services/fecha_util.dart';
import 'package:agenda_front/ui/buttons/custom_outlined_button.dart';
import 'package:agenda_front/ui/cards/white_card.dart';
import 'package:agenda_front/ui/inputs/custom_inputs.dart';
import 'package:agenda_front/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PersonaFormView extends StatelessWidget {
  final Persona? persona;
  const PersonaFormView(this.persona, {super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PersonaProvider>(context, listen: false);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Formulario de Persona',
                style: CustomLabels.h1,
              ),
              CustomOutlinedButton(
                  onPressed: () => Navigator.of(context).pop(), text: 'Volver')
            ],
          ),
          WhiteCard(
              title: persona?.nombre ?? 'Crear registro',
              child: FormBuilder(
                  key: PersonaProvider.formKey,
                  child: Column(
                    children: [
                      FormBuilderTextField(
                        name: 'id',
                        initialValue: persona?.id,
                        enabled: false,
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Codigo del registro',
                            label: 'ID',
                            icon: Icons.numbers),
                      ),
                      FormBuilderSwitch(
                        name: 'activo',
                        title: const Text('Estado del registro'),
                        initialValue: persona?.activo ?? true,
                        enabled: false,
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Estado del registro',
                            label: 'Activo',
                            icon: Icons.done),
                      ),
                      FormBuilderTextField(
                          name: 'nombre',
                          initialValue: persona?.nombre,
                          enabled: persona?.activo ?? true,
                          decoration: CustomInputs.loginInputDecoration(
                              hint: 'Nombre completo',
                              label: 'Nombre y Apellido',
                              icon: Icons.info),
                          validator: FormBuilderValidators.required(
                              errorText: 'Campo obligatorio')),
                      FormBuilderTextField(
                          name: 'documentoIdentidad',
                          initialValue: persona?.documentoIdentidad,
                          enabled: persona?.activo ?? true,
                          decoration: CustomInputs.loginInputDecoration(
                              hint:
                                  'Numero de documento, C.I., R.G., C.P.F., D.N.I., pasaporte...',
                              label: 'Documento de Identidad',
                              icon: Icons.perm_identity),
                          validator: FormBuilderValidators.required(
                              errorText: 'Campo obligatorio')),
                      FormBuilderDateTimePicker(
                          name: 'fechaNacimiento',
                          format: FechaUtil.dateFormat,
                          initialValue: persona?.fechaNacimiento,
                          enabled: persona?.activo ?? true,
                          decoration: CustomInputs.loginInputDecoration(
                              hint: 'dd/MM/yyyy',
                              label: 'Fecha de Nacimiento',
                              icon: Icons.calendar_month),
                          validator: FormBuilderValidators.required(
                              errorText: 'Campo obligatorio')),
                      FormBuilderDropdown(
                          name: 'genero',
                          initialValue: persona?.genero,
                          enabled: persona?.activo ?? true,
                          decoration: CustomInputs.loginInputDecoration(
                              hint: 'Seleccionar genero',
                              label: 'Genero',
                              icon: Icons.male),
                          validator: FormBuilderValidators.required(
                              errorText: 'Campo obligatorio'),
                          items: Generos.values
                              .map((genero) => DropdownMenuItem(
                                  alignment: AlignmentDirectional.center,
                                  value: genero.name,
                                  child: Text(
                                      toBeginningOfSentenceCase(genero.name)!)))
                              .toList()),
                      FormBuilderTextField(
                          name: 'telefono',
                          initialValue: persona?.telefono,
                          enabled: persona?.activo ?? true,
                          decoration: CustomInputs.loginInputDecoration(
                              hint: 'Telefono de contacto',
                              label: 'Telefono',
                              icon: Icons.phone),
                          validator: FormBuilderValidators.minLength(7,
                              errorText:
                                  'Numero de telefono muy corto para ser válido')),
                      FormBuilderTextField(
                          name: 'celular',
                          initialValue: persona?.celular,
                          enabled: persona?.activo ?? true,
                          decoration: CustomInputs.loginInputDecoration(
                              hint: 'Celular de contacto',
                              label: 'Celular',
                              icon: Icons.phone_android),
                          validator: FormBuilderValidators.minLength(7,
                              errorText:
                                  'Numero de celular muy corto para ser válido')),
                      FormBuilderTextField(
                          name: 'direccion',
                          initialValue: persona?.direccion,
                          enabled: persona?.activo ?? true,
                          decoration: CustomInputs.loginInputDecoration(
                              hint: 'Direccion de domicilio',
                              label: 'Direccion',
                              icon: Icons.gps_fixed))
                    ],
                  )))
        ],
      ),
    );
  }
}
