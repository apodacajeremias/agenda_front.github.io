import 'package:agenda_front/constants.dart';
import 'package:agenda_front/extensions.dart';
import 'package:agenda_front/providers.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/enums/genero.dart';
import 'package:agenda_front/src/models/enums/idioma.dart';
import 'package:agenda_front/src/models/enums/moneda.dart';
import 'package:agenda_front/translate.dart';
import 'package:agenda_front/ui/custom_inputs.dart';
import 'package:agenda_front/ui/widgets/elevated_button.dart';
import 'package:agenda_front/ui/widgets/link_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    final formKeyPersonal = GlobalKey<FormBuilderState>();
    final formKeyProfesional = GlobalKey<FormBuilderState>();
    final formKeyEmpresarial = GlobalKey<FormBuilderState>();
    final formKeyAcceso = GlobalKey<FormBuilderState>();
    final provider = Provider.of<AuthProvider>(context, listen: false);
    return Container(
      margin: const EdgeInsets.only(top: maximumSizing),
      padding: const EdgeInsets.symmetric(horizontal: defaultSizing),
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: defaultSizing),
            Text(AppLocalizations.of(context)!.appTitle,
                style: context.headlineLarge),
            const SizedBox(height: defaultSizing),
            Text(AppLocalizations.of(context)!.registrarNuevaMembresia,
                style: context.titleLarge),
            const SizedBox(height: defaultSizing),
            LinkButton(
                text: 'Volver al login',
                onPressed: () {
                  NavigationService.replaceTo(RouterService.loginRoute);
                }),
            const SizedBox(height: defaultSizing),
            Expanded(
              child: Stepper(
                elevation: 0,
                controlsBuilder: (context, details) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (currentStep >= 0) ...[
                        if (currentStep != 0) ...[
                          LinkButton(
                            text: AppLocalizations.of(context)!.volver,
                            onPressed: details.onStepCancel,
                          )
                        ],
                        if (currentStep != 3) ...[
                          EButton(
                            text: AppLocalizations.of(context)!.continuar,
                            onPressed: details.onStepContinue,
                          )
                        ] else ...[
                          EButton(
                            text: AppLocalizations.of(context)!.crearCuenta,
                            onPressed: details.onStepContinue,
                          )
                        ]
                      ],
                    ],
                  );
                },
                steps: [
                  Step(
                      state: currentStep >= 0
                          ? StepState.complete
                          : StepState.indexed,
                      isActive: currentStep == 0,
                      title: Text(
                        AppLocalizations.of(context)!.datosPersonales,
                        style: context.titleLarge,
                      ),
                      content: _InformacionPersonal(formKeyPersonal)),
                  Step(
                      state: currentStep >= 1
                          ? StepState.complete
                          : StepState.indexed,
                      isActive: currentStep == 1,
                      title: Text(
                        AppLocalizations.of(context)!.datosProfesionales,
                        style: context.titleLarge,
                      ),
                      content: _InformacionProfesional(formKeyProfesional)),
                  Step(
                      state: currentStep >= 2
                          ? StepState.complete
                          : StepState.indexed,
                      isActive: currentStep == 2,
                      title: Text(
                        AppLocalizations.of(context)!.datosEmpresariales,
                        style: context.titleLarge,
                      ),
                      content: _InformacionEmpresarial(formKeyEmpresarial)),
                  Step(
                      state: currentStep >= 3
                          ? StepState.complete
                          : StepState.indexed,
                      isActive: currentStep == 3,
                      title: Text(
                        AppLocalizations.of(context)!.datosAcceso,
                        style: context.titleLarge,
                      ),
                      content: _InformacionAcceso(formKeyAcceso)),
                ],
                currentStep: currentStep,
                onStepContinue: () async {
                  if (currentStep != 3) {
                    if (currentStep == 0) {
                      if (formKeyPersonal.currentState!.saveAndValidate()) {
                        // TODO: validar en servidor que cedula no sea duplicada
                        final documentoIdentidad = formKeyPersonal.currentState!
                            .fields['persona.documentoIdentidad']!.value;
                        if (await Provider.of<PersonaProvider>(context,
                                listen: false)
                            .existeDocumento(documentoIdentidad)) {
                          if (context.mounted) {
                            formKeyPersonal.currentState!
                                .fields['persona.documentoIdentidad']
                                ?.invalidate(AppLocalizations.of(context)!
                                    .documentoIdentidadYaExiste);
                          }
                        } else {
                          provider.registerRequest
                              .addAll(formKeyPersonal.currentState!.value);
                          setState(() {
                            currentStep += 1;
                          });
                        }
                      }
                    }
                    if (currentStep == 1) {
                      if (formKeyProfesional.currentState!.saveAndValidate()) {
                        provider.registerRequest
                            .addAll(formKeyProfesional.currentState!.value);
                        setState(() {
                          currentStep += 1;
                        });
                      }
                    }
                    if (currentStep == 2) {
                      if (formKeyEmpresarial.currentState!.saveAndValidate()) {
                        provider.registerRequest
                            .addAll(formKeyEmpresarial.currentState!.value);
                        setState(() {
                          currentStep += 1;
                        });
                      }
                    }
                  } else {
                    if (formKeyAcceso.currentState!.saveAndValidate()) {
                      final email = formKeyAcceso
                          .currentState!.fields['persona.user.email']!.value;
                      if (await Provider.of<UserProvider>(context,
                              listen: false)
                          .existe(email)) {
                        if (context.mounted) {
                          formKeyAcceso
                              .currentState!.fields['persona.user.email']
                              ?.invalidate(AppLocalizations.of(context)!
                                  .correoNoDisponible);
                        }
                      } else {
                        provider.registerRequest
                            .addAll(formKeyAcceso.currentState!.value);
                        // final registerRequest = formKeyPersonal.currentState!.value;
                        // print(formKeyPersonal.currentState!.value);
                        // print(formKeyProfesional.currentState!.value);
                        // print(formKeyEmpresarial.currentState!.value);
                        // print(formKeyAcceso.currentState!.value);
                        // registerRequest
                        //   ..addAll(formKeyProfesional.currentState!.value)
                        //   ..addAll(formKeyEmpresarial.currentState!.value)
                        //   ..addAll(formKeyAcceso.currentState!.value);
                        // print(registerRequest);
                        print(provider.registerRequest);
                        await provider.register(provider.registerRequest);
                      }
                    }
                  }
                  print(currentStep);
                },
                onStepCancel: () {
                  if (currentStep != 0) {
                    setState(() {
                      currentStep -= 1;
                    });
                  }
                },
                type: context.isDesktop
                    ? StepperType.horizontal
                    : StepperType.vertical,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InformacionPersonal extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  const _InformacionPersonal(this.formKey);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: maximumSizing),
      padding: const EdgeInsets.symmetric(horizontal: defaultSizing),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 370),
          child: FormBuilder(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: defaultSizing),
                Text(AppLocalizations.of(context)!.completarDatosPersonales,
                    style: context.titleLarge),
                const SizedBox(height: defaultSizing),
                FormBuilderTextField(
                  name: "persona.nombre",
                  decoration: CustomInputs.form(
                      label: AppLocalizations.of(context)!.nombreTag,
                      hint: AppLocalizations.of(context)!.nombreHint,
                      icon: Icons.info_outline),
                  validator: FormBuilderValidators.required(
                      errorText:
                          AppLocalizations.of(context)!.nombreObligatorio),
                ),
                const SizedBox(height: defaultSizing),
                FormBuilderTextField(
                  name: "persona.documentoIdentidad",
                  decoration: CustomInputs.form(
                      label:
                          AppLocalizations.of(context)!.documentoIdentidadTag,
                      hint: AppLocalizations.of(context)!.documentoIdentidadTag,
                      icon: Icons.info_outline),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.integer(
                        errorText: AppLocalizations.of(context)!.soloNumeros),
                    FormBuilderValidators.required(
                        errorText:
                            AppLocalizations.of(context)!.campoObligatorio)
                  ]),
                ),
                const SizedBox(height: defaultSizing),
                FormBuilderDateTimePicker(
                    name: 'persona.fechaNacimiento',
                    format: dateFormat,
                    initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                    decoration: CustomInputs.form(
                        hint: AppLocalizations.of(context)!.fechaNacimientoTag,
                        label: AppLocalizations.of(context)!.fechaNacimientoTag,
                        icon: Icons.cake_outlined),
                    validator: FormBuilderValidators.required(
                        errorText:
                            AppLocalizations.of(context)!.campoObligatorio),
                    inputType: InputType.date,
                    valueTransformer: (value) => value?.toIso8601String()),
                const SizedBox(height: defaultSizing),
                FormBuilderDropdown(
                  name: 'persona.genero',
                  initialValue: Genero.OTRO,
                  decoration: CustomInputs.form(
                      label: AppLocalizations.of(context)!.generoTag,
                      hint: AppLocalizations.of(context)!.generoTag,
                      icon: Icons.info_outline),
                  items: Genero.values
                      .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                              '${toBeginningOfSentenceCase(e.toString())}')))
                      .toList(),
                  validator: FormBuilderValidators.required(
                      errorText:
                          AppLocalizations.of(context)!.campoObligatorio),
                  valueTransformer: (value) => value?.name,
                ),
                const SizedBox(height: defaultSizing),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InformacionProfesional extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  const _InformacionProfesional(this.formKey);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: maximumSizing),
      padding: const EdgeInsets.symmetric(horizontal: defaultSizing),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 370),
          child: FormBuilder(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: defaultSizing),
                Text(AppLocalizations.of(context)!.completarDatosProfesionales,
                    style: context.titleLarge),
                const SizedBox(height: defaultSizing),
                FormBuilderTextField(
                  name: "persona.colaborador.registroContribuyente",
                  decoration: CustomInputs.form(
                      label: AppLocalizations.of(context)!
                          .registroContribuyenteTag,
                      hint: AppLocalizations.of(context)!
                          .registroContribuyenteTag,
                      icon: Icons.info_outline),
                  validator: FormBuilderValidators.required(
                      errorText:
                          AppLocalizations.of(context)!.campoObligatorio),
                ),
                const SizedBox(height: defaultSizing),
                FormBuilderTextField(
                  name: "persona.colaborador.registroProfesional",
                  decoration: CustomInputs.form(
                      label:
                          AppLocalizations.of(context)!.registroProfesionalTag,
                      hint:
                          AppLocalizations.of(context)!.registroProfesionalTag,
                      icon: Icons.info_outline),
                  validator: FormBuilderValidators.required(
                      errorText:
                          AppLocalizations.of(context)!.campoObligatorio),
                ),
                const SizedBox(height: defaultSizing),
                FormBuilderTextField(
                  name: "persona.colaborador.profesion",
                  decoration: CustomInputs.form(
                      label: AppLocalizations.of(context)!.profesionTag,
                      hint: AppLocalizations.of(context)!.profesionTag,
                      icon: Icons.info_outline),
                  validator: FormBuilderValidators.required(
                      errorText:
                          AppLocalizations.of(context)!.campoObligatorio),
                ),
                const SizedBox(height: defaultSizing),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InformacionEmpresarial extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  const _InformacionEmpresarial(this.formKey);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: maximumSizing),
      padding: const EdgeInsets.symmetric(horizontal: defaultSizing),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 370),
          child: FormBuilder(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: defaultSizing),
                Text(AppLocalizations.of(context)!.completarDatosEmpresariales,
                    style: context.titleLarge),
                const SizedBox(height: defaultSizing),
                FormBuilderTextField(
                  name: "empresa.nombre",
                  decoration: CustomInputs.form(
                      label: AppLocalizations.of(context)!.nombreTag,
                      hint: AppLocalizations.of(context)!.nombreHint,
                      icon: Icons.info_outline),
                  validator: FormBuilderValidators.required(
                      errorText:
                          AppLocalizations.of(context)!.nombreObligatorio),
                ),
                const SizedBox(height: defaultSizing),
                FormBuilderTextField(
                  name: "empresa.registroContribuyente",
                  decoration: CustomInputs.form(
                      label: AppLocalizations.of(context)!
                          .registroContribuyenteTag,
                      hint: AppLocalizations.of(context)!
                          .registroContribuyenteTag,
                      icon: Icons.info_outline),
                  validator: FormBuilderValidators.required(
                      errorText:
                          AppLocalizations.of(context)!.campoObligatorio),
                ),
                const SizedBox(height: defaultSizing),
                FormBuilderDateTimePicker(
                    name: 'empresa.fechaInauguracion',
                    format: dateFormat,
                    initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                    decoration: CustomInputs.form(
                        hint:
                            AppLocalizations.of(context)!.fechaInauguracionTag,
                        label:
                            AppLocalizations.of(context)!.fechaInauguracionTag,
                        icon: Icons.schedule),
                    validator: FormBuilderValidators.required(
                        errorText:
                            AppLocalizations.of(context)!.campoObligatorio),
                    inputType: InputType.date,
                    valueTransformer: (value) => value?.toIso8601String()),
                const SizedBox(height: defaultSizing),
                FormBuilderTextField(
                  name: "empresa.direccion",
                  decoration: CustomInputs.form(
                      label: AppLocalizations.of(context)!.direccionTag,
                      hint: AppLocalizations.of(context)!.direccionTag,
                      icon: Icons.location_on_outlined),
                  validator: FormBuilderValidators.required(
                      errorText:
                          AppLocalizations.of(context)!.campoObligatorio),
                ),
                const SizedBox(height: defaultSizing),
                FormBuilderTextField(
                  name: "empresa.celular",
                  decoration: CustomInputs.form(
                      label: AppLocalizations.of(context)!.celularTag,
                      hint: AppLocalizations.of(context)!.celularHint,
                      icon: Icons.phone_android_outlined),
                  validator: FormBuilderValidators.required(
                      errorText:
                          AppLocalizations.of(context)!.campoObligatorio),
                ),
                const SizedBox(height: defaultSizing),
                FormBuilderTextField(
                  name: "empresa.telefono",
                  decoration: CustomInputs.form(
                      label: AppLocalizations.of(context)!.telefonoTag,
                      hint: AppLocalizations.of(context)!.telefonoHint,
                      icon: Icons.phone_outlined),
                  validator: FormBuilderValidators.required(
                      errorText:
                          AppLocalizations.of(context)!.campoObligatorio),
                ),
                const SizedBox(height: defaultSizing),
                FormBuilderDropdown(
                  name: 'empresa.moneda',
                  initialValue: Moneda.GUARANI,
                  items: [
                    DropdownMenuItem(
                        value: Moneda.GUARANI,
                        child: Text(
                            '${toBeginningOfSentenceCase(Moneda.GUARANI.toString())}'))
                  ],
                  validator: FormBuilderValidators.required(
                      errorText:
                          AppLocalizations.of(context)!.campoObligatorio),
                  valueTransformer: (value) => value?.name,
                ),
                const SizedBox(height: defaultSizing),
                FormBuilderDropdown(
                  name: 'empresa.idioma',
                  initialValue: Idioma.CASTELLANO,
                  items: [
                    DropdownMenuItem(
                        value: Idioma.CASTELLANO,
                        child: Text(
                            '${toBeginningOfSentenceCase(Idioma.CASTELLANO.toString())}'))
                  ],
                  validator: FormBuilderValidators.required(
                      errorText:
                          AppLocalizations.of(context)!.campoObligatorio),
                  valueTransformer: (value) => value?.name,
                ),
                const SizedBox(height: defaultSizing),
                FormBuilderImagePicker(
                  name: 'file',
                  decoration:
                      const InputDecoration(labelText: 'Seleccione su logo'),
                  maxImages: 1,
                  validator: FormBuilderValidators.required(
                      errorText:
                          AppLocalizations.of(context)!.campoObligatorio),
                  onImage: (p0) {
                    print('onImage');
                    print(p0);
                  },
                  valueTransformer: (value) {
                    print('valueTransformer');
                    print(value);
                  },
                ),
                const SizedBox(height: defaultSizing),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InformacionAcceso extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  const _InformacionAcceso(this.formKey);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: maximumSizing),
      padding: const EdgeInsets.symmetric(horizontal: defaultSizing),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 370),
          child: FormBuilder(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: defaultSizing),
                Text(AppLocalizations.of(context)!.completarDatosAcceso,
                    style: context.titleLarge),
                const SizedBox(height: defaultSizing),
                FormBuilderTextField(
                  name: "persona.user.email",
                  decoration: CustomInputs.form(
                      label: AppLocalizations.of(context)!.correoTag,
                      hint: AppLocalizations.of(context)!.correoHint,
                      icon: Icons.supervised_user_circle_sharp),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText:
                            AppLocalizations.of(context)!.correoObligatorio),
                    FormBuilderValidators.email(
                        errorText:
                            AppLocalizations.of(context)!.correoInvalido),
                  ]),
                ),

                const SizedBox(height: defaultSizing),
                // Password
                FormBuilderTextField(
                  name: "persona.user.password",
                  decoration: CustomInputs.form(
                      label: AppLocalizations.of(context)!.contrasenaTag,
                      hint: '********',
                      icon: Icons.lock),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: AppLocalizations.of(context)!
                            .contrasenaObligatoria),
                    FormBuilderValidators.minLength(8,
                        errorText: AppLocalizations.of(context)!
                            .contrasenaSinLargor('min')),
                    FormBuilderValidators.maxLength(30,
                        errorText: AppLocalizations.of(context)!
                            .contrasenaSinLargor('max'))
                  ]),
                  obscureText: true,
                ),
                const SizedBox(height: defaultSizing),
                // Matching Password
                FormBuilderTextField(
                  name: "persona.user.matchingPassword",
                  decoration: CustomInputs.form(
                      label: AppLocalizations.of(context)!.contrasenaRepetirTag,
                      hint: '********',
                      icon: Icons.lock_outline),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: AppLocalizations.of(context)!
                            .contrasenaRepetidaObligatoria),
                    FormBuilderValidators.minLength(8,
                        errorText: AppLocalizations.of(context)!
                            .contrasenaSinLargor('min')),
                    FormBuilderValidators.maxLength(30,
                        errorText: AppLocalizations.of(context)!
                            .contrasenaSinLargor('max')),
                    (matchingPassword) {
                      final password = formKey
                          .currentState?.fields['persona.user.password']!.value;
                      return password.contains(matchingPassword)
                          ? null
                          : AppLocalizations.of(context)!
                              .contrasenaRepetidaInvalida;
                    }
                  ]),
                  obscureText: true,
                ),
                const SizedBox(height: defaultSizing),
                FormBuilderCheckbox(
                    name: "persona.user.termsAndConditionsAccepted",
                    title: Text(
                        AppLocalizations.of(context)!.terminosCondicionesTag)),
                const SizedBox(height: defaultSizing),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
