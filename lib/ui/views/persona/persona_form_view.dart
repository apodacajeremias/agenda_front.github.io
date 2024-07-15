import 'package:agenda_front/constants.dart';
import 'package:agenda_front/extensions.dart';
import 'package:agenda_front/providers.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/entities/persona.dart';
import 'package:agenda_front/src/models/enums/genero.dart';
import 'package:agenda_front/src/models/security/role.dart';
import 'package:agenda_front/translate.dart';
import 'package:agenda_front/ui/custom_inputs.dart';
import 'package:agenda_front/ui/widgets/elevated_button.dart';
import 'package:agenda_front/ui/widgets/form_footer.dart';
import 'package:agenda_front/ui/widgets/form_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PersonaFormView extends StatelessWidget {
  // Para construccion asincrona
  // final Future? future;
  // const PersonaFormView({super.key, this.future});
  final String? id;

  const PersonaFormView({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return id != null
        ? FutureBuilder(
            future: Provider.of<PersonaProvider>(context, listen: false)
                .buscar(id!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _FormView(
                  persona: snapshot.data,
                );
              }
              return _FormView();
            },
          )
        : _FormView();
  }
}

class _FormView extends StatefulWidget {
  final Persona? persona;
  const _FormView({this.persona});

  @override
  State<_FormView> createState() => __FormViewState();
}

class __FormViewState extends State<_FormView> {
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    // final session = Provider.of<AuthProvider>(context, listen: false).persona;
    final hoy = DateTime.now();
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        FormHeader(
            title: widget.persona?.id == null
                ? AppLocalizations.of(context)!.persona('registrar')
                : AppLocalizations.of(context)!.persona('editar')),
        Stepper(
          elevation: 0,
          currentStep: currentStep,
          controlsBuilder: (context, details) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  hoy.formatDate(),
                  style: context.labelLarge,
                )
              ],
            );
          },
          steps: [
            Step(
              title: Text(AppLocalizations.of(context)!.datosPersonales),
              content: _InformacionPersonal(persona: widget.persona),
              state: currentStep == 0 ? StepState.editing : StepState.indexed,
            ),
            if (widget.persona != null) ...[
              Step(
                  title: Text(AppLocalizations.of(context)!.datosProfesionales),
                  content: _InformacionProfesional(persona: widget.persona!),
                  state: (currentStep == 1)
                      ? StepState.editing
                      : (widget.persona != null)
                          ? StepState.indexed
                          : StepState.disabled),
              Step(
                  title: Text(AppLocalizations.of(context)!.datosAcceso),
                  content: _InformacionCredencial(persona: widget.persona!),
                  state: (currentStep == 2)
                      ? StepState.editing
                      : (widget.persona!.colaborador != null)
                          ? StepState.indexed
                          : StepState.disabled),
            ] else ...[
              Step(
                  title: Text(AppLocalizations.of(context)!.datosProfesionales),
                  content: Container(),
                  state: StepState.disabled),
              Step(
                  title: Text(AppLocalizations.of(context)!.datosAcceso),
                  content: Container(),
                  state: StepState.disabled),
            ]
          ],
          onStepTapped: (index) => setState(() {
            currentStep = index;
          }),
        ),
      ],
    );
  }
}

class _InformacionPersonal extends StatelessWidget {
  const _InformacionPersonal({
    required this.persona,
  });

  final Persona? persona;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    final provider = Provider.of<PersonaProvider>(context, listen: false);
    final session = Provider.of<AuthProvider>(context, listen: false).persona;
    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          if (persona?.id != null) ...[
            const SizedBox(height: defaultSizing),
            FormBuilderTextField(
              name: 'id',
              initialValue: persona?.id,
              enabled: false,
              decoration: CustomInputs.form(
                  label: AppLocalizations.of(context)!.idTag,
                  hint: AppLocalizations.of(context)!.idHint,
                  icon: Icons.qr_code_rounded),
            ),
          ],
          const SizedBox(height: defaultSizing),
          FormBuilderTextField(
            name: 'nombre',
            initialValue: persona?.nombre,
            decoration: CustomInputs.form(
                label: AppLocalizations.of(context)!.nombreTag,
                hint: AppLocalizations.of(context)!.nombreHint,
                icon: Icons.supervised_user_circle_sharp),
            validator: FormBuilderValidators.required(
                errorText: AppLocalizations.of(context)!.nombreObligatorio),
          ),
          const SizedBox(height: defaultSizing),
          FormBuilderTextField(
            name: 'documentoIdentidad',
            initialValue: persona?.documentoIdentidad,
            decoration: CustomInputs.form(
                label: AppLocalizations.of(context)!.documentoIdentidadTag,
                hint: AppLocalizations.of(context)!.documentoIdentidadTag,
                icon: Icons.info_outline),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: AppLocalizations.of(context)!.campoObligatorio),
              FormBuilderValidators.integer(
                  errorText: AppLocalizations.of(context)!.soloNumeros),
            ]),
          ),
          const SizedBox(height: defaultSizing),
          FormBuilderDateTimePicker(
              name: 'fechaNacimiento',
              initialDate: persona?.fechaNacimiento,
              format: dateFormat,
              initialTime: TimeOfDay.fromDateTime(DateTime.now()),
              decoration: CustomInputs.form(
                  hint: AppLocalizations.of(context)!.fechaNacimientoTag,
                  label: AppLocalizations.of(context)!.fechaNacimientoTag,
                  icon: Icons.cake_outlined),
              validator: FormBuilderValidators.required(
                  errorText: 'Campo obligatorio'),
              inputType: InputType.date,
              valueTransformer: (value) => value?.toIso8601String()),
          const SizedBox(height: defaultSizing),
          FormBuilderDropdown(
            name: 'genero',
            initialValue: persona?.genero,
            decoration: CustomInputs.form(
                label: AppLocalizations.of(context)!.generoTag,
                hint: AppLocalizations.of(context)!.generoTag,
                icon: Icons.info_outline),
            items: Genero.values
                .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text('${toBeginningOfSentenceCase(e.toString())}')))
                .toList(),
            validator:
                FormBuilderValidators.required(errorText: 'Campo obligatorio'),
            valueTransformer: (value) => value?.name,
          ),
          const SizedBox(height: defaultSizing),
          FormBuilderTextField(
            name: 'telefono',
            initialValue: persona?.telefono,
            decoration: CustomInputs.form(
                label: AppLocalizations.of(context)!.telefonoTag,
                hint: AppLocalizations.of(context)!.telefonoHint,
                icon: Icons.info_outline),
            validator: FormBuilderValidators.integer(
                errorText: AppLocalizations.of(context)!.soloNumeros),
          ),
          const SizedBox(height: defaultSizing),
          FormBuilderTextField(
            name: 'celular',
            initialValue: persona?.celular,
            decoration: CustomInputs.form(
                label: AppLocalizations.of(context)!.celularTag,
                hint: AppLocalizations.of(context)!.celularHint,
                icon: Icons.info_outline),
            validator: FormBuilderValidators.integer(
                errorText: AppLocalizations.of(context)!.soloNumeros),
          ),
          const SizedBox(height: defaultSizing),
          FormBuilderTextField(
              name: 'direccion',
              initialValue: persona?.direccion,
              decoration: CustomInputs.form(
                  label: AppLocalizations.of(context)!.direccionTag,
                  hint: AppLocalizations.of(context)!.direccionTag,
                  icon: Icons.info_outline)),
          const SizedBox(height: defaultSizing),
          FormBuilderTextField(
            name: 'observacion',
            initialValue: persona?.observacion,
            keyboardType: TextInputType.multiline,
            minLines: 2,
            maxLines: 5,
            decoration: CustomInputs.form(
                label: AppLocalizations.of(context)!.observacionesTag,
                hint: AppLocalizations.of(context)!.observacionesTag,
                icon: Icons.comment_rounded),
          ),
          const SizedBox(height: defaultSizing),
          FormFooter(onConfirm: () async {
            try {
              if (session!.user!.role == Role.USER) {
                NotificationService.showSnackbarError(
                    AppLocalizations.of(context)!
                        .noTienePermisosSuficientes(session.user!.role!.name));
                return;
              }
              if (formKey.currentState!.saveAndValidate()) {
                final documentoIdentidad =
                    formKey.currentState!.fields['documentoIdentidad']!.value;
                if (await Provider.of<PersonaProvider>(context, listen: false)
                    .existeDocumento(documentoIdentidad)) {
                  if (context.mounted) {
                    formKey.currentState!.fields['documentoIdentidad']
                        ?.invalidate(AppLocalizations.of(context)!
                            .documentoIdentidadYaExiste);
                  }
                  return;
                }

                final data = formKey.currentState!.value;
                final persona = await provider.registrar(data);
                if (context.mounted) {
                  NavigationService.navigateTo(RouterService.personasEditRoute
                      .replaceAll(':id', persona.id));
                }
              }
            } catch (e) {
              rethrow;
            }
          }),
          const SizedBox(height: defaultSizing),
        ],
      ),
    );
  }
}

class _InformacionProfesional extends StatelessWidget {
  const _InformacionProfesional({
    required this.persona,
  });

  final Persona persona;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    final provider = Provider.of<ColaboradorProvider>(context, listen: false);
    final session = Provider.of<AuthProvider>(context, listen: false).persona;
    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          if (persona.colaborador?.id != null) ...[
            const SizedBox(height: defaultSizing),
            FormBuilderTextField(
              name: 'id',
              initialValue: persona.colaborador?.id,
              enabled: false,
              decoration: CustomInputs.form(
                  label: AppLocalizations.of(context)!.idTag,
                  hint: AppLocalizations.of(context)!.idHint,
                  icon: Icons.qr_code_rounded),
            ),
          ],
          const SizedBox(height: defaultSizing),
          FormBuilderTextField(
            name: '-nombre',
            initialValue: persona.nombre,
            enabled: false,
            decoration: CustomInputs.form(
                label: AppLocalizations.of(context)!.nombreTag,
                hint: AppLocalizations.of(context)!.nombreHint,
                icon: Icons.supervised_user_circle_sharp),
            validator: FormBuilderValidators.required(
                errorText: AppLocalizations.of(context)!.nombreObligatorio),
          ),
          const SizedBox(height: defaultSizing),
          FormBuilderTextField(
            name: 'registroContribuyente',
            initialValue: persona.colaborador?.registroContribuyente,
            decoration: CustomInputs.form(
                label: AppLocalizations.of(context)!.registroContribuyenteTag,
                hint: AppLocalizations.of(context)!.registroContribuyenteTag,
                icon: Icons.info_outline),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.integer(
                  errorText: AppLocalizations.of(context)!.soloNumeros),
              FormBuilderValidators.required(
                  errorText: AppLocalizations.of(context)!.campoObligatorio)
            ]),
          ),
          const SizedBox(height: defaultSizing),
          FormBuilderTextField(
            name: 'registroProfesional',
            initialValue: persona.colaborador?.registroProfesional,
            decoration: CustomInputs.form(
                label: AppLocalizations.of(context)!.registroProfesionalTag,
                hint: AppLocalizations.of(context)!.registroProfesionalTag,
                icon: Icons.info_outline),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.integer(
                  errorText: AppLocalizations.of(context)!.soloNumeros),
              FormBuilderValidators.required(
                  errorText: AppLocalizations.of(context)!.campoObligatorio)
            ]),
          ),
          const SizedBox(height: defaultSizing),
          FormBuilderTextField(
            name: 'cargo',
            initialValue: persona.colaborador?.cargo,
            decoration: CustomInputs.form(
                label: AppLocalizations.of(context)!.profesionTag,
                hint: AppLocalizations.of(context)!.profesionTag,
                icon: Icons.info_outline),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: AppLocalizations.of(context)!.campoObligatorio)
            ]),
          ),
          const SizedBox(height: defaultSizing),
          FormFooter(onConfirm: () async {
            try {
              if (session!.user!.role == Role.USER) {
                NotificationService.showSnackbarError(
                    AppLocalizations.of(context)!
                        .noTienePermisosSuficientes(session.user!.role!.name));
                return;
              }
              if (formKey.currentState!.saveAndValidate()) {
                if (context.mounted) {
                  final registroContribuyente = formKey
                      .currentState!.fields['registroContribuyente']!.value;
                  final registroProfesional = formKey
                      .currentState!.fields['registroProfesional']!.value;
                  final existeRegistroContribuyente =
                      await Provider.of<ColaboradorProvider>(context,
                              listen: false)
                          .existeRegistroContribuyente(registroContribuyente);
                  final existeRegistroProfesional =
                      await Provider.of<ColaboradorProvider>(context,
                              listen: false)
                          .existeRegistroProfesional(registroProfesional);
                  if (existeRegistroContribuyente ||
                      existeRegistroProfesional) {
                    if (existeRegistroProfesional) {
                      formKey.currentState!.fields['registroProfesional']
                          ?.invalidate(AppLocalizations.of(context)!
                              .registroProfesionalYaExiste);
                    }
                    if (existeRegistroContribuyente) {
                      formKey.currentState!.fields['registroContribuyente']
                          ?.invalidate(AppLocalizations.of(context)!
                              .registroContribuyenteYaExiste);
                    }
                    return;
                  }
                }

                Map<String, dynamic> data = {'persona.id': persona.id};
                data.addAll(formKey.currentState!.value);
                await provider.registrar(data);
                if (context.mounted) {
                  NavigationService.navigateTo(RouterService.personasEditRoute
                      .replaceAll(':id', persona.id));
                }
              }
            } catch (e) {
              rethrow;
            }
          }),
          const SizedBox(height: defaultSizing),
        ],
      ),
    );
  }
}

class _InformacionCredencial extends StatelessWidget {
  const _InformacionCredencial({
    required this.persona,
  });

  final Persona persona;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    final provider = Provider.of<UserProvider>(context, listen: false);
    final session = Provider.of<AuthProvider>(context, listen: false).persona;
    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          if (persona.user?.id != null) ...[
            const SizedBox(height: defaultSizing),
            FormBuilderTextField(
              name: 'id',
              initialValue: persona.user?.id,
              enabled: false,
              decoration: CustomInputs.form(
                  label: AppLocalizations.of(context)!.idTag,
                  hint: AppLocalizations.of(context)!.idHint,
                  icon: Icons.qr_code_rounded),
            ),
          ],
          const SizedBox(height: defaultSizing),
          FormBuilderTextField(
            name: 'email',
            initialValue: persona.user?.username,
            decoration: CustomInputs.form(
                label: AppLocalizations.of(context)!.correoTag,
                hint: AppLocalizations.of(context)!.correoHint,
                icon: Icons.mail_rounded),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.email(
                  errorText: AppLocalizations.of(context)!.correoInvalido),
              FormBuilderValidators.required(
                  errorText: AppLocalizations.of(context)!.correoObligatorio)
            ]),
          ),
          const SizedBox(height: defaultSizing),
          FormBuilderDropdown(
              name: 'role',
              initialValue: persona.user?.role,
              items: Role.values
                  .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                  .toList()),

          // TODO: APARECER SI ES PERFIL DEL USUARIO EN SESION
          if (persona.user?.id == null) ...[
            const SizedBox(height: defaultSizing),
            FormBuilderTextField(
              name: 'password',
              initialValue: persona.documentoIdentidad,
              decoration: CustomInputs.form(
                  label: AppLocalizations.of(context)!.contrasenaTag,
                  hint: AppLocalizations.of(context)!.contrasenaTag,
                  icon: Icons.lock_rounded),
            ),
            const SizedBox(height: defaultSizing),
            FormBuilderTextField(
              name: 'matchingPassword',
              initialValue: persona.documentoIdentidad,
              decoration: CustomInputs.form(
                  label: AppLocalizations.of(context)!.contrasenaRepetirTag,
                  hint: AppLocalizations.of(context)!.contrasenaRepetirTag,
                  icon: Icons.lock_outline_rounded),
            ),
          ],
          if (persona.user?.id != null) ...[
            const SizedBox(height: defaultSizing),
            FormBuilderCheckbox(
              name: '-enabled',
              title: Text(AppLocalizations.of(context)!.cuentaActivada),
              initialValue: !persona.user!.enabled!,
              enabled: false,
            ),
            const SizedBox(height: defaultSizing),
            FormBuilderCheckbox(
              name: '-accountNonLocked',
              title: Text(AppLocalizations.of(context)!.cuentaBloqueada),
              initialValue: !persona.user!.accountNonLocked!,
              enabled: false,
            ),
            const SizedBox(height: defaultSizing),
            FormBuilderCheckbox(
              name: '-accountNonExpired',
              title: Text(AppLocalizations.of(context)!.cuentaExpirada),
              initialValue: !persona.user!.accountNonExpired!,
              enabled: false,
            ),
            const SizedBox(height: defaultSizing),
            FormBuilderCheckbox(
              name: '-credentialsNonExpired',
              title: Text(AppLocalizations.of(context)!.credencialesExpiradas),
              initialValue: !persona.user!.credentialsNonExpired!,
              enabled: false,
            ),
            const SizedBox(height: mediumSizing),
            if (persona.user!.enabled!) ...[
              EButton(
                  text: 'Confirmar registro',
                  icon: Icons.check,
                  onPressed: () {
                    debugPrint('Confirmar registro pressed');
                  }),
              const SizedBox(height: defaultSizing),
              EButton(
                  text: 'Reenviar confirmación de registro',
                  icon: Icons.check,
                  onPressed: () {
                    debugPrint('Reenviar confirmación de registro pressed');
                  }),
            ],
            if (persona.user!.role == Role.ADMIN) ...[
              const SizedBox(height: defaultSizing),
              EButton(
                  text: 'Solicitar cambio forzado de contraseña',
                  icon: Icons.change_circle_rounded,
                  onPressed: () {
                    debugPrint(
                        'Solicitar cambio forzado de contraseña pressed');
                  }),
            ],
            if (persona.user!.id == session!.user!.id) ...[
              const SizedBox(height: defaultSizing),
              EButton(
                  text: 'Cambiar contraseña voluntariamente',
                  icon: Icons.check,
                  onPressed: () {
                    debugPrint('Cambiar contraseña voluntariamente pressed');
                  }),
            ],
          ],
          const SizedBox(height: defaultSizing),
          FormFooter(onConfirm: () async {
            if (session!.user!.role == Role.USER) {
              NotificationService.showSnackbarError(
                  AppLocalizations.of(context)!
                      .noTienePermisosSuficientes(session.user!.role!.name));
              return;
            }
            try {
              if (formKey.currentState!.saveAndValidate()) {
                final email = formKey.currentState!.fields['email']!.value;
                if (await Provider.of<UserProvider>(context, listen: false)
                    .existe(email)) {
                  if (context.mounted) {
                    formKey.currentState!.fields['email']?.invalidate(
                        AppLocalizations.of(context)!.correoNoDisponible);
                  }
                  return;
                }
                Map<String, dynamic> data = {'persona.id': persona.id};
                data.addAll(formKey.currentState!.value);
                await provider.registrar(data);
                if (context.mounted) {
                  NavigationService.navigateTo(RouterService.personasEditRoute
                      .replaceAll(':id', persona.id));
                }
              }
            } catch (e) {
              rethrow;
            }
          }),
          const SizedBox(height: defaultSizing),
        ],
      ),
    );
  }
}
