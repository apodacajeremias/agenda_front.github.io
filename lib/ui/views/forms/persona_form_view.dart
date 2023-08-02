// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/models/enums/genero.dart';
import 'package:agenda_front/models/entities/persona.dart';
import 'package:agenda_front/providers/persona_provider.dart';
import 'package:agenda_front/services/fecha_util.dart';
import 'package:agenda_front/services/notifications_service.dart';
import 'package:agenda_front/ui/buttons/custom_icon_button.dart';
import 'package:agenda_front/ui/buttons/link_text.dart';
import 'package:agenda_front/ui/cards/white_card.dart';
import 'package:agenda_front/ui/inputs/custom_inputs.dart';
import 'package:agenda_front/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PersonaFormView extends StatefulWidget {
  final Persona? persona;

  const PersonaFormView({super.key, this.persona});

  @override
  State<PersonaFormView> createState() => _PersonaFormViewState();
}

class _PersonaFormViewState extends State<PersonaFormView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int edad = 0;
    final provider = Provider.of<PersonaProvider>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // TODO: ENCAPSULAR EN UN WIDGET ESTE ENCABEZADO
              Text(
                'Formulario',
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
                if (widget.persona?.id != null) ...[
                  SizedBox(height: 10),
                  Row(children: [
                    Expanded(
                        child: FormBuilderTextField(
                            name: 'id',
                            initialValue: widget.persona?.id,
                            enabled: false,
                            decoration: CustomInputs.form(
                                hint: 'Codigo Identificador',
                                label: 'ID',
                                icon: Icons.qr_code))),
                    SizedBox(width: 10),
                    Expanded(
                        child: FormBuilderSwitch(
                            name: 'activo',
                            title: Text(
                              'Estado del registro',
                              style: CustomLabels.h3,
                            ),
                            initialValue: widget.persona?.activo,
                            decoration: CustomInputs.noBorder()))
                  ])
                ],
                SizedBox(height: 10),
                FormBuilderTextField(
                    name: 'nombre',
                    initialValue: widget.persona?.nombre,
                    enabled: widget.persona?.activo ?? true,
                    decoration: CustomInputs.form(
                        hint: 'Nombre completo',
                        label: 'Nombre y Apellido',
                        icon: Icons.info),
                    validator: FormBuilderValidators.required(
                        errorText: 'Campo obligatorio')),
                SizedBox(height: 10),
                Row(children: [
                  Expanded(
                      child: FormBuilderTextField(
                          name: 'documentoIdentidad',
                          initialValue: widget.persona?.documentoIdentidad,
                          enabled: widget.persona?.activo ?? true,
                          decoration: CustomInputs.form(
                              hint:
                                  'Numero de documento, C.I., R.G., C.P.F., D.N.I., pasaporte...',
                              label: 'Documento de Identidad',
                              icon: Icons.perm_identity),
                          validator: FormBuilderValidators.required(
                              errorText: 'Campo obligatorio'))),
                  SizedBox(width: 10),
                  Expanded(
                    child: Row(children: [
                      Expanded(
                        child: FormBuilderDateTimePicker(
                          name: 'fechaNacimiento',
                          format: FechaUtil.dateFormat,
                          initialValue:
                              widget.persona?.fechaNacimiento ?? DateTime.now(),
                          enabled: widget.persona?.activo ?? true,
                          decoration: CustomInputs.form(
                              hint: 'Fecha de nacimiento',
                              label: 'Fecha de nacimiento',
                              icon: Icons.cake),
                          validator: FormBuilderValidators.required(
                              errorText: 'Campo obligatorio'),
                          onChanged: (value) => setState(() {
                            edad = FechaUtil.calcularEdad(value!);
                          }),
                          inputType: InputType.date,
                          valueTransformer: (value) => value!.toIso8601String(),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'edad',
                          initialValue: edad.toString(),
                          enabled: widget.persona?.activo ?? true,
                          decoration: CustomInputs.form(
                              hint: 'Edad de la persona',
                              label: 'Edad hasta la fecha',
                              icon: Icons.numbers),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(height: 10),
                ]),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                        child: FormBuilderDropdown(
                            name: 'genero',
                            initialValue: widget.persona?.genero,
                            enabled: widget.persona?.activo ?? true,
                            decoration: CustomInputs.form(
                                hint: 'Seleccionar genero',
                                label: 'Genero',
                                icon: Icons.male),
                            validator: FormBuilderValidators.required(
                                errorText: 'Campo obligatorio'),
                            items: Genero.values
                                .map((genero) => DropdownMenuItem(
                                    value: genero.name,
                                    child: Text(toBeginningOfSentenceCase(
                                        genero.name)!)))
                                .toList())),
                  ],
                ),
                SizedBox(height: 10),
                FormBuilderTextField(
                    name: 'telefono',
                    initialValue: widget.persona?.telefono,
                    enabled: widget.persona?.activo ?? true,
                    decoration: CustomInputs.form(
                        hint: 'Telefono de contacto',
                        label: 'Telefono',
                        icon: Icons.phone),
                    validator: FormBuilderValidators.minLength(7,
                        errorText:
                            'Numero de telefono muy corto para ser válido')),
                SizedBox(height: 10),
                FormBuilderTextField(
                    name: 'celular',
                    initialValue: widget.persona?.celular,
                    enabled: widget.persona?.activo ?? true,
                    decoration: CustomInputs.form(
                        hint: 'Celular de contacto',
                        label: 'Celular',
                        icon: Icons.phone_android),
                    validator: FormBuilderValidators.minLength(7,
                        errorText:
                            'Numero de celular muy corto para ser válido')),
                SizedBox(height: 10),
                FormBuilderTextField(
                    name: 'direccion',
                    initialValue: widget.persona?.direccion,
                    enabled: widget.persona?.activo ?? true,
                    decoration: CustomInputs.form(
                        hint: 'Direccion de domicilio',
                        label: 'Direccion',
                        icon: Icons.gps_fixed),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.minLength(5,
                          errorText: 'Direccion muy corta, de mas detalles'),
                      FormBuilderValidators.maxLength(255,
                          errorText: 'Direccion muy larga')
                    ])),
                SizedBox(height: 10),
                FormBuilderTextField(
                    name: 'observacion',
                    initialValue: widget.persona?.observacion,
                    enabled: widget.persona?.activo ?? true,
                    decoration: CustomInputs.form(
                        hint: 'Observacion',
                        label: 'Observaciones',
                        icon: Icons.gps_fixed),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.minLength(5,
                          errorText: 'Observacion muy corta, de mas detalles'),
                      FormBuilderValidators.maxLength(255,
                          errorText: 'Observacion muy larga')
                    ])),
                SizedBox(height: 10),
                FormBuilderImagePicker(
                  name: 'fotoPerfil',
                  decoration: CustomInputs.form(
                      hint: 'Selecciona una foto para el perfil',
                      label: 'Foto de perfil',
                      icon: Icons.image),
                  maxImages: 1,
                ),
                Row(
                  children: [
                    CustomIconButton(
                        onPressed: () async {
                          if (provider.validateForm()) {
                            provider.saveForm();
                            final id = provider
                                .formKey.currentState!.fields['id']?.value;
                            try {
                              if (id == null) {
                                await provider.guardar(
                                    provider.formKey.currentState!.value);
                                NotificationsService.showSnackbar(
                                    'Registro creado!');
                              } else {
                                await provider.actualizar(
                                    id, provider.formKey.currentState!.value);
                                NotificationsService.showSnackbar(
                                    'Registro modificado!');
                              }
                              if (context.mounted) {
                                Navigator.of(context).pop();
                              }
                            } catch (e) {
                              Navigator.of(context).pop;
                              if (id == null) {
                                NotificationsService.showSnackbarError(
                                    'No se pudo crear el registro');
                              } else {
                                NotificationsService.showSnackbarError(
                                    'No se pudo modificar el registro');
                              }
                              rethrow;
                            }
                          }
                        },
                        text:
                            widget.persona?.id == null ? 'Crear' : 'Modificar',
                        icon: widget.persona?.id == null
                            ? Icons.save
                            : Icons.edit,
                        color: Colors.green.withOpacity(0.3))
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
