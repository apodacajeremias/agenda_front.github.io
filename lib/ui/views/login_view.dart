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
      margin: const EdgeInsets.only(top: 100),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 370),
          child: FormBuilder(
              key: provider.formKey,
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
                          errorText: 'El correo no es correcto.')
                    ]),
                  ),
                  const SizedBox(height: 20),
                  // Password
                  FormBuilderTextField(
                    name: "password",
                    decoration: CustomInputs.form(
                        label: 'Contraseña de seguridad',
                        hint: '********',
                        icon: Icons.lock),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Contraseña obligatoria.'),
                      FormBuilderValidators.minLength(6,
                          errorText:
                              'La contraseña debe de ser de 6 caracteres'),
                    ]),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  MyElevatedButton(
                    onPressed: () async {
                      if (provider.saveAndValidate()) {
                        await provider.login(provider.formData());
                      }
                    },
                    text: 'Ingresar',
                  ),
                  const SizedBox(height: 20),
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
