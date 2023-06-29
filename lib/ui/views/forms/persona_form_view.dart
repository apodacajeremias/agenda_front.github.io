// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/models/enums/generos.dart';
import 'package:agenda_front/models/persona.dart';
import 'package:agenda_front/providers/persona_provider.dart';
import 'package:agenda_front/services/fecha_util.dart';
import 'package:agenda_front/services/notifications_service.dart';
import 'package:agenda_front/ui/buttons/custom_icon_button.dart';
import 'package:agenda_front/ui/buttons/custom_outlined_button.dart';
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
  int _edad = 0;
  @override
  void initState() {
    super.initState();
  }

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
                'Formulario de Cliente',
                style: CustomLabels.h1,
              ),
              CustomOutlinedButton(
                  onPressed: () => Navigator.of(context).pop(), text: 'Volver')
            ],
          ),
          WhiteCard(
              title: widget.persona?.nombre ?? 'Crear registro',
              child: FormBuilder(
                key: provider.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (widget.persona?.id != null) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(height: 10),
                          Expanded(
                            child: FormBuilderTextField(
                              name: 'id',
                              initialValue: widget.persona?.id ?? 'Sin codigo',
                              enabled: false,
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Codigo Identificador',
                                  label: 'ID',
                                  icon: Icons.qr_code),
                            ),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: FormBuilderCheckbox(
                              name: 'activo',
                              title: Text('Estado de registro'),
                              initialValue: widget.persona?.activo,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 10),
                          Expanded(
                            child: FormBuilderDateTimePicker(
                              name: 'fechaCreacion',
                              format: FechaUtil.dateFormat,
                              initialValue: widget.persona?.fechaCreacion,
                              enabled: false,
                            ),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: FormBuilderDateTimePicker(
                              name: 'fechaModificacion',
                              format: FechaUtil.dateFormat,
                              initialValue: widget.persona?.fechaModificacion,
                              enabled: false,
                            ),
                          )
                        ],
                      ),
                    ],
                    SizedBox(height: 10),
                    FormBuilderTextField(
                        name: 'nombre',
                        initialValue: widget.persona?.nombre,
                        enabled: widget.persona?.activo ?? true,
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Nombre completo',
                            label: 'Nombre y Apellido',
                            icon: Icons.info),
                        validator: FormBuilderValidators.required(
                            errorText: 'Campo obligatorio')),
                    SizedBox(height: 10),
                    FormBuilderTextField(
                        name: 'documentoIdentidad',
                        initialValue: widget.persona?.documentoIdentidad,
                        enabled: widget.persona?.activo ?? true,
                        decoration: CustomInputs.loginInputDecoration(
                            hint:
                                'Numero de documento, C.I., R.G., C.P.F., D.N.I., pasaporte...',
                            label: 'Documento de Identidad',
                            icon: Icons.perm_identity),
                        validator: FormBuilderValidators.required(
                            errorText: 'Campo obligatorio')),
                    SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: FormBuilderDateTimePicker(
                              name: 'fechaNacimiento',
                              format: FechaUtil.dateFormat,
                              initialValue: widget.persona?.fechaNacimiento,
                              enabled: widget.persona?.activo ?? true,
                              validator: FormBuilderValidators.required(
                                  errorText: 'Campo obligatorio'),
                              onChanged: (value) => setState(() {
                                _edad = FechaUtil.calcularEdad(value!);
                              }),
                            ),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: FormBuilderTextField(
                              name: 'edad',
                              initialValue: widget.persona?.edad.toString() ??
                                  _edad.toString(),
                              enabled: widget.persona?.activo ?? true,
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Edad hasta la fecha',
                                  label: 'Edad',
                                  icon: Icons.numbers),
                            ),
                          ),
                        ]),
                    SizedBox(height: 10),
                    FormBuilderDropdown(
                        name: 'genero',
                        initialValue: widget.persona?.genero,
                        enabled: widget.persona?.activo ?? true,
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
                    SizedBox(height: 10),
                    FormBuilderTextField(
                        name: 'telefono',
                        initialValue: widget.persona?.telefono,
                        enabled: widget.persona?.activo ?? true,
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Telefono de contacto',
                            label: 'Telefono',
                            icon: Icons.phone),
                        validator: FormBuilderValidators.minLength(7,
                            errorText:
                                'Numero de telefono muy corto para ser válido')),
                    FormBuilderTextField(
                        name: 'celular',
                        initialValue: widget.persona?.celular,
                        enabled: widget.persona?.activo ?? true,
                        decoration: CustomInputs.loginInputDecoration(
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
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Direccion de domicilio',
                            label: 'Direccion',
                            icon: Icons.gps_fixed),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.minLength(5,
                              errorText:
                                  'Direccion muy corta, de mas detalles'),
                          FormBuilderValidators.maxLength(255,
                              errorText: 'Direccion muy larga')
                        ])),
                    SizedBox(height: 10),
                    FormBuilderTextField(
                        name: 'observacion',
                        initialValue: widget.persona?.observacion,
                        enabled: widget.persona?.activo ?? true,
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Observacion',
                            label: 'Observaciones',
                            icon: Icons.gps_fixed),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.minLength(5,
                              errorText:
                                  'Observacion muy corta, de mas detalles'),
                          FormBuilderValidators.maxLength(255,
                              errorText: 'Observacion muy larga')
                        ])),
                    SizedBox(height: 10),
                    FormBuilderImagePicker(
                      name: 'fotoPerfil',
                      decoration: CustomInputs.loginInputDecoration(
                          hint: 'Selecciona una foto para el perfil',
                          label: 'Foto de perfil',
                          icon: Icons.image),
                      maxImages: 1,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomIconButton(
                            onPressed: () async {
                              provider.formKey.currentState!
                                  .saveAndValidate(focusOnInvalid: true);
                              var json = provider.formKey.currentState!.value;
                              print(json);
                              var guardar = Persona.fromJson(json);
                              try {
                                if (guardar.id == null) {
                                  await provider.guardar(guardar);
                                  NotificationsService.showSnackbar(
                                      'Registro de $guardar.nombre creado!');
                                } else {
                                  await provider.actualizar(
                                      guardar.id!, guardar);
                                  NotificationsService.showSnackbar(
                                      'Registro de $guardar.nombre modificado!');
                                }
                              } catch (e) {
                                Navigator.of(context).pop;
                                if (guardar.id == null) {
                                  NotificationsService.showSnackbarError(
                                      'No se pudo crear la persona');
                                } else {
                                  NotificationsService.showSnackbarError(
                                      'No se pudo modificar la persona');
                                }
                                rethrow;
                              }
                            },
                            text: widget.persona?.id == null
                                ? 'Crear'
                                : 'Modificar',
                            icon: widget.persona?.id == null
                                ? Icons.save
                                : Icons.edit,
                            color: Colors.green.withOpacity(0.3)),
                        CustomOutlinedButton(
                            onPressed: () async {
                              Navigator.of(context).pop;
                              if (widget.persona?.id == null) {
                                NotificationsService.showSnackbarError(
                                    'No se ha creado el registro');
                              } else {
                                NotificationsService.showSnackbarError(
                                    'No se ha modificado el registro');
                              }
                            },
                            text: widget.persona?.id == null
                                ? 'Cerrar'
                                : 'Cancelar',
                            color: Colors.red.withOpacity(0.3))
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
