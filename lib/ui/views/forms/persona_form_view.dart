// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/models/enums/generos.dart';
import 'package:agenda_front/models/persona.dart';
import 'package:agenda_front/providers/persona_provider.dart';
import 'package:agenda_front/services/fecha_util.dart';
import 'package:agenda_front/ui/buttons/custom_icon_button.dart';
import 'package:agenda_front/ui/buttons/link_text.dart';
import 'package:agenda_front/ui/cards/white_card.dart';
import 'package:agenda_front/ui/inputs/custom_inputs.dart';
import 'package:agenda_front/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PersonaFormView extends StatefulWidget {
  final Persona persona;

  const PersonaFormView({super.key, required this.persona});

  @override
  State<PersonaFormView> createState() => _PersonaFormViewState();
}

class _PersonaFormViewState extends State<PersonaFormView> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PersonaProvider>(context, listen: false);

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Registro',
                  style: CustomLabels.h1,
                ),
                LinkText(text: 'Volver', color: Colors.blue)
              ],
            ),
            WhiteCard(
                title: widget.persona.id == null
                    ? 'Editar registro'
                    : 'Crear registro',
                child: FormBuilder(
                  key: provider.formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      FormBuilderTextField(
                        name: 'nombre',
                        initialValue: widget.persona.nombre,
                        enabled: widget.persona.activo ?? true,
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Ingrese el nombre',
                            label: 'Nombre',
                            icon: Icons.person_pin),
                        validator: FormBuilderValidators.required(
                            errorText: 'Campo obligatorio'),
                        onChanged: (value) {
                          widget.persona.nombre = value;
                        },
                      ),
                      SizedBox(height: 10),
                      FormBuilderTextField(
                        name: 'nombre',
                        initialValue: widget.persona.documentoIdentidad,
                        enabled: widget.persona.activo ?? true,
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Ingrese el documento de identidad',
                            label: 'Documento',
                            icon: Icons.person_pin),
                        validator: FormBuilderValidators.required(
                            errorText: 'Campo obligatorio'),
                        onChanged: (value) {
                          widget.persona.documentoIdentidad = value;
                        },
                      ),
                      SizedBox(height: 10),
                      FormBuilderDateTimePicker(
                        name: 'fechaNacimiento',
                        initialValue: widget.persona.fechaNacimiento,
                        enabled: widget.persona.activo ?? true,
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Ingrese la fecha de nacimiento',
                            label: 'Fecha de nacimiento',
                            icon: Icons.calendar_month),
                        validator: FormBuilderValidators.required(
                            errorText: 'Campo obligatorio'),
                        onChanged: (value) {
                          widget.persona.fechaNacimiento = value;
                        },
                        format: FechaUtil.dateFormat,
                      ),
                      SizedBox(height: 10),
                      FormBuilderDropdown(
                        name: 'genero',
                        items: Generos.values.map((genero) {
                          final generoFormateado =
                              toBeginningOfSentenceCase(genero.name) ??
                                  genero.name;
                          return DropdownMenuItem(
                            alignment: AlignmentDirectional.center,
                            value: genero.name,
                            child: Text(generoFormateado),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 10),
                      FormBuilderTextField(
                        name: 'celular',
                        initialValue: widget.persona.celular,
                        enabled: widget.persona.activo ?? true,
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Ingrese un numero de celular',
                            label: 'Celular',
                            icon: Icons.phone_android),
                        validator: FormBuilderValidators.numeric(
                            errorText: 'Solo numeros'),
                        onChanged: (value) {
                          widget.persona.celular = value;
                        },
                      ),
                      SizedBox(height: 10),
                      FormBuilderTextField(
                        name: 'telefono',
                        initialValue: widget.persona.telefono,
                        enabled: widget.persona.activo ?? true,
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Ingrese un numero de telefono',
                            label: 'Telefono',
                            icon: Icons.phone),
                        validator: FormBuilderValidators.numeric(
                            errorText: 'Solo numeros'),
                        onChanged: (value) {
                          widget.persona.telefono = value;
                        },
                      ),
                      SizedBox(height: 10),
                      FormBuilderTextField(
                        name: 'correo',
                        initialValue: widget.persona.correo,
                        enabled: widget.persona.activo ?? true,
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Ingrese un correo electronico',
                            label: 'Correo',
                            icon: Icons.email),
                        validator: FormBuilderValidators.email(
                            errorText: 'Ingrese un correo valido'),
                        onChanged: (value) {
                          widget.persona.correo = value;
                        },
                      ),
                      SizedBox(height: 10),
                      FormBuilderTextField(
                        name: 'direccion',
                        initialValue: widget.persona.direccion,
                        enabled: widget.persona.activo ?? true,
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Ingrese la direccion',
                            label: 'Direccion',
                            icon: Icons.gps_fixed),
                        validator: FormBuilderValidators.minWordsCount(3,
                            allowEmpty: true,
                            errorText: 'La direccion debe ser mas especifica'),
                        onChanged: (value) {
                          widget.persona.direccion = value;
                        },
                      ),
                      SizedBox(height: 10),
                      FormBuilderTextField(
                        name: 'observacion',
                        initialValue: widget.persona.observacion,
                        enabled: widget.persona.activo ?? true,
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Ingrese observaciones',
                            label: 'Observacion',
                            icon: Icons.announcement),
                        onChanged: (value) {
                          widget.persona.observacion = value;
                        },
                      ),
                      SizedBox(height: 10),
                      //TODO: agregar un ImagePicker para la foto de perfil
                      CustomIconButton(
                          onPressed: () {
                            provider.formKey.currentState!.save();
                            print(provider.formKey.currentState!.value);
                            (widget.persona.id == null)
                                ? provider.newPersona(widget.persona)
                                : provider.updatePersona(
                                    widget.persona.id!, widget.persona);
                          },
                          text: widget.persona.id == null
                              ? 'Guardar'
                              : 'Actualizar',
                          icon: Icons.save)
                    ],
                  ),
                ))
          ],
        ));
  }
}
