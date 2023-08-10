import 'package:agenda_front/providers/auth_provider.dart';
import 'package:agenda_front/providers/login_form_provider.dart';
import 'package:agenda_front/ui/buttons/my_elevated_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:agenda_front/routers/router.dart';

import 'package:agenda_front/ui/inputs/custom_inputs.dart';
import 'package:agenda_front/ui/buttons/my_text_button.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return ChangeNotifierProvider(
        create: (_) => LoginFormProvider(),
        child: Builder(builder: (context) {
          final loginFormProvider =
              Provider.of<LoginFormProvider>(context, listen: false);

          return Container(
            margin: const EdgeInsets.only(top: 100),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 370),
                child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: loginFormProvider.formKey,
                    child: Column(
                      children: [
                        // Email
                        TextFormField(
                          onFieldSubmitted: (_) =>
                              onFormSubmit(loginFormProvider, authProvider),
                          validator: (value) {
                            if (!EmailValidator.validate(value ?? '')) {
                              return 'Email no válido';
                            }

                            return null;
                          },
                          onChanged: (value) => loginFormProvider.email = value,
                          // style: const TextStyle(color: Colors.white),
                          decoration: CustomInputs.form(
                              hint: 'Ingrese su correo',
                              label: 'Email',
                              icon: Icons.email),
                        ),

                        const SizedBox(height: 20),

                        // Password
                        TextFormField(
                          onFieldSubmitted: (_) =>
                              onFormSubmit(loginFormProvider, authProvider),
                          onChanged: (value) =>
                              loginFormProvider.password = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese su contraseña';
                            }
                            if (value.length < 6) {
                              return 'La contraseña debe de ser de 6 caracteres';
                            }

                            return null; // Válido
                          },
                          obscureText: true,
                          decoration: CustomInputs.form(
                              hint: '*********',
                              label: 'Contraseña',
                              icon: Icons.lock),
                        ),

                        const SizedBox(height: 20),
                        MyElevatedButton(
                          onPressed: () =>
                              onFormSubmit(loginFormProvider, authProvider),
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
        }));
  }

  void onFormSubmit(
      LoginFormProvider loginFormProvider, AuthProvider authProvider) {
    final isValid = loginFormProvider.validateForm();
    if (isValid) {
      authProvider.login(loginFormProvider.email, loginFormProvider.password);
    }
  }
}
