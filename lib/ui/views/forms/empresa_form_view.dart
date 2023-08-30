// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/constants.dart';
import 'package:agenda_front/models/entities/empresa.dart';
import 'package:agenda_front/models/enums/idioma.dart';
import 'package:agenda_front/models/enums/moneda.dart';
import 'package:agenda_front/providers/empresa_provider.dart';
import 'package:agenda_front/ui/cards/white_card.dart';
import 'package:agenda_front/ui/inputs/custom_inputs.dart';
import 'package:agenda_front/ui/shared/forms/form_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EmpresaFormView extends StatelessWidget {
  final Empresa empresa;
  const EmpresaFormView({super.key, required this.empresa});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmpresaProvider>(context, listen: false);
    return Container(
        padding: EdgeInsets.all(defaultPadding),
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            FormHeader(title: 'Datos sobre la empresa'),
            WhiteCard(
                title: 'Configurar datos',
                child: FormBuilder(
                  key: provider.formKey,
                  child: Column(
                    children: [
                      if (empresa.id != null) ...[
                        const SizedBox(height: defaultPadding),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: FormBuilderTextField(
                                  name: 'ID',
                                  initialValue: empresa.id,
                                  enabled: false,
                                  decoration: CustomInputs.form(
                                      label: 'ID',
                                      hint: 'ID',
                                      icon: Icons.qr_code),
                                )),
                            const SizedBox(width: defaultPadding),
                            Expanded(
                                child: FormBuilderSwitch(
                              name: 'activo',
                              title: const Text('Estado del registro'),
                              initialValue: empresa.activo,
                              decoration: CustomInputs.noBorder(),
                            )),
                          ],
                        )
                      ],
                      FormBuilderTextField(
                        name: 'nombre',
                        initialValue: empresa.nombre,
                        enabled: empresa.activo ?? true,
                        decoration: CustomInputs.form(
                            label: 'Nombre de la empresa',
                            hint: 'Nombre con el cual actua la empresa',
                            icon: Icons.info),
                      ),
                      SizedBox(height: 10),
                      FormBuilderTextField(
                        name: 'direccion',
                        initialValue: empresa.direccion,
                        enabled: empresa.activo ?? true,
                        decoration: CustomInputs.form(
                            label: 'Dirrecion de la empresa',
                            hint: 'Calles, barrio, estado, pais.',
                            icon: Icons.info),
                        keyboardType: TextInputType.multiline,
                        minLines: 2,
                        maxLines: 5,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              child: FormBuilderTextField(
                            name: 'celular',
                            enabled: empresa.activo ?? true,
                            decoration: CustomInputs.form(
                                label: 'Celular',
                                hint: 'Celular de contacto',
                                icon: Icons.phone),
                          )),
                          SizedBox(width: 10),
                          Expanded(
                              child: FormBuilderTextField(
                            name: 'telefono',
                            enabled: empresa.activo ?? true,
                            decoration: CustomInputs.form(
                                label: 'Telefono',
                                hint: 'Telefono de contacto',
                                icon: Icons.phone),
                          ))
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              child: FormBuilderDateTimePicker(
                            name: 'fechaInauguracion',
                            enabled: empresa.activo ?? true,
                            decoration: CustomInputs.form(
                                label: 'Fecha de Inauguracion',
                                hint: 'Inicio de las actividades',
                                icon: Icons.schedule),
                          )),
                          SizedBox(width: 10),
                          Expanded(
                              child: FormBuilderTextField(
                            name: 'registroContribuyente',
                            enabled: empresa.activo ?? true,
                            decoration: CustomInputs.form(
                                label: 'Registro de Contribuyente',
                                hint: 'RUC, CNPJ, RUT',
                                icon: Icons.request_quote),
                          ))
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              child: FormBuilderDropdown(
                            name: 'moneda',
                            items: Moneda.values
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                          toBeginningOfSentenceCase(e.name)!),
                                    ))
                                .toList(),
                            validator: FormBuilderValidators.required(
                                errorText: 'Campo obligatorio'),
                            valueTransformer: (value) => value?.name,
                          )),
                          SizedBox(width: 10),
                          Expanded(
                            child: FormBuilderDropdown(
                              name: 'idioma',
                              items: Idioma.values
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(
                                            toBeginningOfSentenceCase(e.name)!),
                                      ))
                                  .toList(),
                              validator: FormBuilderValidators.required(
                                  errorText: 'Campo obligatorio'),
                              valueTransformer: (value) => value?.name,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      FormBuilderImagePicker(
                        name: 'logo',
                        decoration: CustomInputs.form(
                            hint: 'Selecciona una foto para el logo',
                            label: 'Imagen de logo',
                            icon: Icons.image),
                        maxImages: 1,
                      ),
                    ],
                  ),
                )),
          ],
        ));
  }
}
