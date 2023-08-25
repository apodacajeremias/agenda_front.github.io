import 'package:agenda_front/models/enums/genero.dart';
import 'package:agenda_front/models/entities/persona.dart';
import 'package:agenda_front/providers/persona_provider.dart';
import 'package:agenda_front/utils/fecha_util.dart';
import 'package:agenda_front/ui/cards/white_card.dart';
import 'package:agenda_front/ui/inputs/custom_inputs.dart';
import 'package:agenda_front/ui/shared/forms/form_footer.dart';
import 'package:agenda_front/ui/shared/forms/form_header.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PersonaFormView extends StatelessWidget {
  final Persona? persona;

  const PersonaFormView({super.key, this.persona});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PersonaProvider>(context, listen: false);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const FormHeader(title: 'Persona'),
          WhiteCard(
              child: FormBuilder(
            key: provider.formKey,
            child: Column(
              children: [
                if (persona?.id != null) ...[
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: FormBuilderTextField(
                            name: 'id',
                            initialValue: persona?.id,
                            enabled: false,
                            decoration: CustomInputs.form(
                                label: 'ID', hint: 'ID', icon: Icons.qr_code),
                          )),
                      const SizedBox(width: 10),
                      Expanded(
                          child: FormBuilderSwitch(
                        name: 'activo',
                        title: const Text('Estado del registro'),
                        initialValue: persona?.activo,
                        decoration: CustomInputs.noBorder(),
                      )),
                    ],
                  )
                ],
                const SizedBox(height: 10),
                FormBuilderTextField(
                    name: 'nombre',
                    initialValue: persona?.nombre,
                    enabled: persona?.activo ?? true,
                    decoration: CustomInputs.form(
                        hint: 'Nombre completo',
                        label: 'Nombre y Apellido',
                        icon: Icons.info),
                    validator: FormBuilderValidators.required(
                        errorText: 'Campo obligatorio')),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                        child: FormBuilderTextField(
                            name: 'documentoIdentidad',
                            initialValue: persona?.documentoIdentidad,
                            enabled: persona?.activo ?? true,
                            decoration: CustomInputs.form(
                                hint:
                                    'Numero de documento, C.I., R.G., C.P.F., D.N.I., pasaporte...',
                                label: 'Documento de Identidad',
                                icon: Icons.perm_identity),
                            validator: FormBuilderValidators.required(
                                errorText: 'Campo obligatorio'))),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FormBuilderDropdown(
                        name: 'genero',
                        initialValue: persona?.genero ?? Genero.OTRO,
                        enabled: persona?.activo ?? true,
                        decoration: CustomInputs.form(
                            label: 'Genero',
                            hint: 'Genero de persona',
                            icon: Icons.info),
                        items: Genero.values
                            .map((g) => DropdownMenuItem(
                                value: g,
                                child: Row(
                                  children: [
                                    Icon(g.icon),
                                    const SizedBox(width: 5),
                                    Text(toBeginningOfSentenceCase(
                                        g.name.toLowerCase())!)
                                  ],
                                )))
                            .toList(),
                        validator: FormBuilderValidators.required(
                            errorText: 'Genero obligatorio'),
                        valueTransformer: (value) => value?.name,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(children: [
                  Expanded(
                    child: Row(children: [
                      Expanded(
                        child: FormBuilderDateTimePicker(
                          name: 'fechaNacimiento',
                          format: FechaUtil.dateFormat,
                          initialValue:
                              persona?.fechaNacimiento ?? DateTime.now(),
                          enabled: persona?.activo ?? true,
                          decoration: CustomInputs.form(
                              hint: 'Fecha de nacimiento',
                              label: 'Fecha de nacimiento',
                              icon: Icons.cake),
                          validator: FormBuilderValidators.required(
                              errorText: 'Campo obligatorio'),
                          onChanged: (value) {
                            provider.formKey.currentState!.fields['edad']!
                                .didChange(
                                    FechaUtil.calcularEdad(value!).toString());
                          },
                          inputType: InputType.date,
                          valueTransformer: (value) => value?.toIso8601String(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'edad',
                          initialValue: (persona != null)
                              ? FechaUtil.calcularEdad(
                                      persona!.fechaNacimiento!)
                                  .toString()
                              : '0',
                          enabled: persona?.activo ?? true,
                          decoration: CustomInputs.form(
                              hint: 'Edad de la persona',
                              label: 'Edad hasta la fecha',
                              icon: Icons.numbers),
                        ),
                      ),
                    ]),
                  ),
                ]),
                const SizedBox(height: 10),
                FormBuilderTextField(
                    name: 'telefono',
                    initialValue: persona?.telefono,
                    enabled: persona?.activo ?? true,
                    decoration: CustomInputs.form(
                        hint: 'Telefono de contacto',
                        label: 'Telefono',
                        icon: Icons.phone),
                    validator: FormBuilderValidators.minLength(7,
                        errorText:
                            'Numero de telefono muy corto para ser válido',
                        allowEmpty: true)),
                const SizedBox(height: 10),
                FormBuilderTextField(
                    name: 'celular',
                    initialValue: persona?.celular,
                    enabled: persona?.activo ?? true,
                    decoration: CustomInputs.form(
                        hint: 'Celular de contacto',
                        label: 'Celular',
                        icon: Icons.phone_android),
                    validator: FormBuilderValidators.minLength(7,
                        errorText:
                            'Numero de celular muy corto para ser válido',
                        allowEmpty: true)),
                const SizedBox(height: 10),
                FormBuilderTextField(
                    name: 'direccion',
                    initialValue: persona?.direccion,
                    enabled: persona?.activo ?? true,
                    decoration: CustomInputs.form(
                        hint: 'Direccion de domicilio',
                        label: 'Direccion',
                        icon: Icons.gps_fixed),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.minLength(5,
                          errorText: 'Direccion muy corta, de mas detalles',
                          allowEmpty: true),
                      FormBuilderValidators.maxLength(255,
                          errorText: 'Direccion muy larga')
                    ])),
                const SizedBox(height: 10),
                FormBuilderTextField(
                    name: 'observacion',
                    initialValue: persona?.observacion,
                    enabled: persona?.activo ?? true,
                    decoration: CustomInputs.form(
                        hint: 'Observacion',
                        label: 'Observaciones',
                        icon: Icons.gps_fixed),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.minLength(5,
                          errorText: 'Observacion muy corta, de mas detalles',
                          allowEmpty: true),
                      FormBuilderValidators.maxLength(255,
                          errorText: 'Observacion muy larga')
                    ])),
                const SizedBox(height: 10),
                FormBuilderImagePicker(
                  name: 'fotoPerfil',
                  decoration: CustomInputs.form(
                      hint: 'Selecciona una foto para el perfil',
                      label: 'Foto de perfil',
                      icon: Icons.image),
                  maxImages: 1,
                  // valueTransformer: (imagenes) {
                  //   if (imagenes != null) {
                  //     for (var imagen in imagenes) {
                  //       return imagen.readAsBytes();
                  //     }
                  //   }
                  // },
                ),
                FormFooter(onConfirm: () async {
                  if (provider.saveAndValidate()) {
                    Map<String, dynamic> data = Map.from(provider.formData());
                    MultipartFile avatar = MultipartFile.fromBytes(
                        await data['fotoPerfil']!.first.readAsBytes());

                    data.addAll({'avatar': avatar});
                    data.remove('fotoPerfil');
                    print(data);
                    // Create a Dio instance
                    final Dio dio = Dio();

                    // Set up the request options

                    Options options = Options(method: 'PUT');

                    // Create a FormData instance to hold the files you want to upload
                    FormData formData = FormData.fromMap(data);
                    formData.fields
                        .removeWhere((element) => element.key == 'fotoPerfil');
                    // Add the files to the FormData instance
                    // formData.files.addAll([
                    //   MapEntry(
                    //       'avatar',
                    //       MultipartFile.fromBytes(
                    //           await data['fotoPerfil']!.first.readAsBytes())),
                    //   // Add more files here if you want
                    // ]);

                    print(formData.files);
                    print(formData.fields);

                    try {
                      // Send the POST request
                      Response response = await dio.put(
                          'http://localhost:8080/api/personas/' + data['id'],
                          data: formData,
                          options: options);

                      // Do something with the response
                      print(response.data);
                    } catch (e) {
                      // show my error
                      print(e);
                    }
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                }),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
