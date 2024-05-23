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
import 'package:agenda_front/ui/widgets/outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class RegistrationView extends StatelessWidget {
  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    final provider = Provider.of<AuthProvider>(context, listen: false);
    return Container(
      margin: const EdgeInsets.only(top: maximumSizing),
      padding: const EdgeInsets.symmetric(horizontal: defaultSizing),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 370),
          child: FormBuilder(
              key: formKey,
              child: Column(
                children: [],
              )),
        ),
      ),
    );
  }
}

class _InformacionPersonal extends StatelessWidget {
  const _InformacionPersonal();

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        const SizedBox(height: defaultSizing),
        Text(AppLocalizations.of(context)!.appTitle,
            style: context.headlineLarge),
        const SizedBox(height: defaultSizing),
        Text(AppLocalizations.of(context)!.completarPerfilAdministrador,
            style: context.titleLarge),
        const SizedBox(height: defaultSizing),
        // Nombre persona
        FormBuilderTextField(
          name: "nombre",
          decoration: CustomInputs.form(
              label: AppLocalizations.of(context)!.nombreTag,
              hint: AppLocalizations.of(context)!.nombreHint,
              icon: Icons.info_outline),
          validator: FormBuilderValidators.required(
              errorText: AppLocalizations.of(context)!.nombreObligatorio),
        ),
        const SizedBox(height: defaultSizing),
        FormBuilderTextField(
          name: "documentoIdentidad",
          decoration: CustomInputs.form(
              label: AppLocalizations.of(context)!.documentoIdentidadTag,
              hint: AppLocalizations.of(context)!.documentoIdentidadTag,
              icon: Icons.info_outline),
          validator: FormBuilderValidators.required(
              errorText: AppLocalizations.of(context)!.campoObligatorio),
        ),
        const SizedBox(height: defaultSizing),
        FormBuilderDateTimePicker(
            name: 'fechaNacimiento',
            format: dateFormat,
            initialTime: TimeOfDay.fromDateTime(DateTime.now()),
            decoration: CustomInputs.form(
                hint: AppLocalizations.of(context)!.fechaNacimientoTag,
                label: AppLocalizations.of(context)!.fechaNacimientoTag,
                icon: Icons.cake_outlined),
            validator:
                FormBuilderValidators.required(errorText: 'Campo obligatorio'),
            inputType: InputType.date,
            valueTransformer: (value) => value?.toIso8601String()),
        const SizedBox(height: defaultSizing),
        FormBuilderTextField(
          name: "direccion",
          decoration: CustomInputs.form(
              label: AppLocalizations.of(context)!.direccionTag,
              hint: AppLocalizations.of(context)!.direccionTag,
              icon: Icons.location_on_outlined),
          validator: FormBuilderValidators.required(
              errorText: AppLocalizations.of(context)!.campoObligatorio),
        ),
        const SizedBox(height: defaultSizing),
        FormBuilderTextField(
          name: "celular",
          decoration: CustomInputs.form(
              label: AppLocalizations.of(context)!.celularTag,
              hint: AppLocalizations.of(context)!.celularHint,
              icon: Icons.phone_android_outlined),
          validator: FormBuilderValidators.required(
              errorText: AppLocalizations.of(context)!.campoObligatorio),
        ),
        const SizedBox(height: defaultSizing),
        FormBuilderTextField(
          name: "telefono",
          decoration: CustomInputs.form(
              label: AppLocalizations.of(context)!.telefonoTag,
              hint: AppLocalizations.of(context)!.telefonoHint,
              icon: Icons.phone_outlined),
          validator: FormBuilderValidators.required(
              errorText: AppLocalizations.of(context)!.campoObligatorio),
        ),
        const SizedBox(height: defaultSizing),
        FormBuilderDropdown(
          name: 'genero',
          initialValue: Genero.OTRO,
          items: [
            DropdownMenuItem(
                value: Genero.OTRO,
                child: Text(
                    '${toBeginningOfSentenceCase(Genero.OTRO.toString())}'))
          ],
          validator:
              FormBuilderValidators.required(errorText: 'Campo obligatorio'),
          valueTransformer: (value) => value?.name,
        ),
        const SizedBox(height: defaultSizing),
        EButton.listo(onPressed: () async {
          if (formKey.currentState!.saveAndValidate()) {
            await Provider.of<AuthProvider>(context, listen: false)
                .completeProfile(
                    Provider.of<AuthProvider>(context, listen: false)
                            .user
                            ?.id ??
                        'NA',
                    formKey.currentState!.value);
          }
        }),
      ],
    );
  }
}

class _InformacionEmpresarial extends StatelessWidget {
  const _InformacionEmpresarial();

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        const SizedBox(height: defaultSizing),
        Text(AppLocalizations.of(context)!.appTitle,
            style: context.headlineLarge),
        const SizedBox(height: defaultSizing),
        Text(AppLocalizations.of(context)!.completarConfiguracion,
            style: context.titleLarge),
        const SizedBox(height: defaultSizing),
        // Nombre empresa
        FormBuilderTextField(
          name: "empresa.nombre",
          decoration: CustomInputs.form(
              label: AppLocalizations.of(context)!.nombreTag,
              hint: AppLocalizations.of(context)!.nombreHint,
              icon: Icons.info_outline),
          validator: FormBuilderValidators.required(
              errorText: AppLocalizations.of(context)!.nombreObligatorio),
        ),
        const SizedBox(height: defaultSizing),
        FormBuilderTextField(
          name: "empresa.registroContribuyente",
          decoration: CustomInputs.form(
              label: AppLocalizations.of(context)!.registroContribuyenteTag,
              hint: AppLocalizations.of(context)!.registroContribuyenteTag,
              icon: Icons.info_outline),
          validator: FormBuilderValidators.required(
              errorText: AppLocalizations.of(context)!.campoObligatorio),
        ),
        const SizedBox(height: defaultSizing),
        FormBuilderDateTimePicker(
            name: 'empresa.fechaInauguracion',
            format: dateFormat,
            initialTime: TimeOfDay.fromDateTime(DateTime.now()),
            decoration: CustomInputs.form(
                hint: AppLocalizations.of(context)!.fechaInauguracionTag,
                label: AppLocalizations.of(context)!.fechaInauguracionTag,
                icon: Icons.schedule),
            validator: FormBuilderValidators.required(
                errorText: AppLocalizations.of(context)!.campoObligatorio),
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
              errorText: AppLocalizations.of(context)!.campoObligatorio),
        ),
        const SizedBox(height: defaultSizing),
        FormBuilderTextField(
          name: "empresa.celular",
          decoration: CustomInputs.form(
              label: AppLocalizations.of(context)!.celularTag,
              hint: AppLocalizations.of(context)!.celularHint,
              icon: Icons.phone_android_outlined),
          validator: FormBuilderValidators.required(
              errorText: AppLocalizations.of(context)!.campoObligatorio),
        ),
        const SizedBox(height: defaultSizing),
        FormBuilderTextField(
          name: "empresa.telefono",
          decoration: CustomInputs.form(
              label: AppLocalizations.of(context)!.telefonoTag,
              hint: AppLocalizations.of(context)!.telefonoHint,
              icon: Icons.phone_outlined),
          validator: FormBuilderValidators.required(
              errorText: AppLocalizations.of(context)!.campoObligatorio),
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
          validator:
              FormBuilderValidators.required(errorText: 'Campo obligatorio'),
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
          validator:
              FormBuilderValidators.required(errorText: 'Campo obligatorio'),
          valueTransformer: (value) => value?.name,
        ),
        const SizedBox(height: defaultSizing),
        EButton.listo(onPressed: () async {
          if (formKey.currentState!.saveAndValidate()) {
            await Provider.of<AuthProvider>(context, listen: false)
                .completeConfiguration(formKey.currentState!.value);
          }
        }),
      ],
    );
  }
}

class _InformacionProfesional extends StatelessWidget {
  const _InformacionProfesional();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _InformacionAcceso extends StatelessWidget {
  const _InformacionAcceso();

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        const SizedBox(height: defaultSizing),
        Text(AppLocalizations.of(context)!.appTitle,
            style: context.headlineLarge),
        const SizedBox(height: defaultSizing),
        Text(AppLocalizations.of(context)!.registrarNuevaMembresia,
            style: context.titleLarge),
        const SizedBox(height: defaultSizing),
        FormBuilderTextField(
          name: "email",
          decoration: CustomInputs.form(
              label: AppLocalizations.of(context)!.correoTag,
              hint: AppLocalizations.of(context)!.correoHint,
              icon: Icons.supervised_user_circle_sharp),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: AppLocalizations.of(context)!.correoObligatorio),
            FormBuilderValidators.email(
                errorText: AppLocalizations.of(context)!.correoInvalido),
          ]),
        ),

        const SizedBox(height: defaultSizing),
        // Password
        FormBuilderTextField(
          name: "password",
          decoration: CustomInputs.form(
              label: AppLocalizations.of(context)!.contrasenaTag,
              hint: '********',
              icon: Icons.lock),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: AppLocalizations.of(context)!.contrasenaObligatoria),
            FormBuilderValidators.minLength(8,
                errorText:
                    AppLocalizations.of(context)!.contrasenaSinLargor('min')),
            FormBuilderValidators.maxLength(30,
                errorText:
                    AppLocalizations.of(context)!.contrasenaSinLargor('max'))
          ]),
          obscureText: true,
        ),
        const SizedBox(height: defaultSizing),
        // Matching Password
        FormBuilderTextField(
          name: "matchingPassword",
          decoration: CustomInputs.form(
              label: AppLocalizations.of(context)!.contrasenaRepetirTag,
              hint: '********',
              icon: Icons.lock_outline),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: AppLocalizations.of(context)!
                    .contrasenaRepetidaObligatoria),
            FormBuilderValidators.minLength(8,
                errorText:
                    AppLocalizations.of(context)!.contrasenaSinLargor('min')),
            FormBuilderValidators.maxLength(30,
                errorText:
                    AppLocalizations.of(context)!.contrasenaSinLargor('max')),
            (matchingPassword) {
              final password = formKey.currentState?.fields['password']!.value;
              return password.contains(matchingPassword)
                  ? null
                  : AppLocalizations.of(context)!.contrasenaRepetidaInvalida;
            }
          ]),
          obscureText: true,
        ),
        const SizedBox(height: defaultSizing),
        OButton(
          onPressed: () async {
            if (formKey.currentState!.saveAndValidate()) {
              final email = formKey.currentState!.fields['email']!.value;
              if (await Provider.of<UserProvider>(context, listen: false)
                  .existe(email)) {
                if (context.mounted) {
                  formKey.currentState!.fields['email']?.invalidate(
                      AppLocalizations.of(context)!.correoNoDisponible);
                }
              } else {
                await provider.register(formKey.currentState!.value);
              }
            }
          },
          text: AppLocalizations.of(context)!.crearCuenta,
        ),
        const SizedBox(height: defaultSizing),
        LinkButton(
          text: AppLocalizations.of(context)!.irLogin,
          onPressed: () {
            Navigator.pushReplacementNamed(context, RouterService.loginRoute);
          },
        )
      ],
    );
  }
}
