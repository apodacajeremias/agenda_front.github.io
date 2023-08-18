import 'package:agenda_front/providers/auth_provider.dart';
import 'package:agenda_front/providers/usuario_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/ui/buttons/my_outlined_button.dart';
import 'package:agenda_front/ui/buttons/my_text_button.dart';
import 'package:agenda_front/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UsuarioProvider>(context, listen: false);
    return Container(
      margin: const EdgeInsets.only(top: 50),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 370),
          child: FormBuilder(
              key: provider.formKey,
              child: Column(
                children: [
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
                      (val) {
                        if (val != null) {
                          return userProvider.existe(val)
                              ? 'El correo no está disponible'
                              : null;
                        } else {
                          return 'Correo electrónico obligatorio.';
                        }
                      },
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
                  // Matching Password
                  FormBuilderTextField(
                    name: "matchingPassword",
                    decoration: CustomInputs.form(
                        label: 'Repita la contraseña de seguridad',
                        hint: '********',
                        icon: Icons.lock_outline),
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
                  MyOutlinedButton(
                    onPressed: () async {
                      if (provider.saveAndValidate()) {
                        await provider.registrar(provider.formData());
                      }
                    },
                    text: 'Crear cuenta',
                  ),

                  const SizedBox(height: 20),
                  MyTextButton(
                    text: 'Ir al login',
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Flurorouter.loginRoute);
                    },
                  )
                ],
              )),
        ),
      ),
    );
  }
}
