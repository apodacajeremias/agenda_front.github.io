import 'package:agenda_front/constants.dart';
import 'package:agenda_front/extensions.dart';
import 'package:agenda_front/src/providers/auth_provider.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/ui/custom_inputs.dart';
import 'package:agenda_front/ui/widgets/elevated_button.dart';
import 'package:agenda_front/ui/widgets/link_button.dart';
import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:agenda_front/translate.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
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
                  Text(AppLocalizations.of(context)!.appTitle,
                      style: context.headlineLarge),
                  const SizedBox(height: defaultSizing),
                  Text(AppLocalizations.of(context)!.bienvenido,
                      style: context.titleLarge),
                  const SizedBox(height: defaultSizing),
                  // Email
                  FormBuilderTextField(
                    name: "email",
                    decoration: CustomInputs.form(
                        label: AppLocalizations.of(context)!.correoTag,
                        hint: AppLocalizations.of(context)!.correoHint,
                        icon: Icons.supervised_user_circle_sharp),
                    autofillHints: const [AutofillHints.email],
                    keyboardType: TextInputType.emailAddress,
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(
                            errorText: AppLocalizations.of(context)!
                                .correoObligatorio),
                        FormBuilderValidators.email(
                            errorText:
                                AppLocalizations.of(context)!.correoInvalido),
                      ],
                    ),
                  ),
                  const SizedBox(height: defaultSizing),
                  // Password
                  FormBuilderTextField(
                    name: "password",
                    decoration: CustomInputs.form(
                        label: AppLocalizations.of(context)!.contrasenaTag,
                        hint: '********',
                        icon: Icons.lock),
                    autofillHints: const [AutofillHints.password],
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
                  EButton(
                    onPressed: () async {
                      if (formKey.currentState!.saveAndValidate()) {
                        await Provider.of<AuthProvider>(context, listen: false)
                            .authenticate(formKey.currentState!.value);
                      }
                    },
                    text: AppLocalizations.of(context)!.ingresar,
                  ),
                  const SizedBox(height: defaultSizing),
                  LinkButton(
                    text: AppLocalizations.of(context)!.nuevaCuenta,
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, RouterService.registerRoute);
                    },
                  )
                ],
              )),
        ),
      ),
    );
  }
}
