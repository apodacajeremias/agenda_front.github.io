import 'package:agenda_front/constants.dart';
import 'package:agenda_front/src/providers/auth_provider.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/ui/custom_inputs.dart';
import 'package:agenda_front/ui/widgets/elevated_button.dart';
import 'package:agenda_front/ui/widgets/link_button.dart';
import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return Container(
      margin: const EdgeInsets.only(top: maximunSizing),
      padding: const EdgeInsets.symmetric(horizontal: defaultSizing),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 370),
          child: FormBuilder(
              key: formKey,
              child: Column(
                children: [
                  // Email
                  FormBuilderTextField(
                    name: "email",
                    decoration: CustomInputs.form(
                        label: 'Correo electrónico',
                        hint: 'Ingrese su correo',
                        icon: Icons.supervised_user_circle_sharp),
                    autofillHints: const [AutofillHints.email],
                    keyboardType: TextInputType.emailAddress,
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(
                            errorText: 'Correo electrónico obligatorio.'),
                        FormBuilderValidators.email(
                            errorText: 'El correo no es correcto.'),
                      ],
                    ),
                  ),
                  const SizedBox(height: defaultSizing),
                  // Password
                  FormBuilderTextField(
                    name: "password",
                    decoration: CustomInputs.form(
                        label: 'Contraseña de seguridad',
                        hint: '********',
                        icon: Icons.lock),
                    autofillHints: const [AutofillHints.password],
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
                  const SizedBox(height: defaultSizing),
                  EButton(
                    onPressed: () async {
                      if (formKey.currentState!.saveAndValidate()) {
                        await Provider.of<AuthProvider>(context, listen: false)
                            .authenticate(formKey.currentState!.value);
                      }
                    },
                    text: 'Ingresar',
                  ),
                  const SizedBox(height: defaultSizing),
                  LinkButton(
                    text: 'Nueva cuenta',
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
