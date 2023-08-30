import 'package:agenda_front/constants.dart';
import 'package:agenda_front/providers/auth_provider.dart';
import 'package:agenda_front/ui/buttons/my_elevated_button.dart';
import 'package:flutter/material.dart';

import 'package:agenda_front/routers/router.dart';

import 'package:agenda_front/ui/inputs/custom_inputs.dart';
import 'package:agenda_front/ui/buttons/my_text_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);

    return Container(
      margin: const EdgeInsets.only(top: defaultPadding * 5),
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 370),
          child: FormBuilder(
              key: provider.loginKey,
              child: Column(
                children: [
                  // Email
                  FormBuilderTextField(
                    name: "email",
                    decoration: CustomInputs.form(
                        label: 'Correo electrónico',
                        hint: 'Ingrese su correo',
                        icon: Icons.supervised_user_circle_sharp),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Correo electrónico obligatorio.'),
                      FormBuilderValidators.email(
                          errorText: 'El correo no es correcto.'),
                    ]),
                  ),
                  const SizedBox(height: defaultPadding),
                  // Password
                  FormBuilderTextField(
                    name: "password",
                    decoration: CustomInputs.form(
                        label: 'Contraseña de seguridad',
                        hint: '********',
                        icon: Icons.lock),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Debe repetir la contraseña.'),
                      FormBuilderValidators.minLength(8,
                          errorText:
                              'La contraseña debe tener minimo 8 caracteres'),
                      FormBuilderValidators.maxLength(30,
                          errorText:
                              'La contraseña debe tener maximo 30 caracteres')
                    ]),
                    obscureText: true,
                  ),
                  const SizedBox(height: defaultPadding),
                  MyElevatedButton(
                    onPressed: () async {
                      if (provider.saveAndValidateLogin()) {
                        await provider.login(provider.formDataLogin());
                      }
                    },
                    text: 'Ingresar',
                  ),
                  const SizedBox(height: defaultPadding),
                  MyTextButton(
                    text: 'Nueva cuenta',
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Flurorouter.registerRoute);
                    },
                  )
                ],
              )),
        ),
      ),
    );
  }
}
