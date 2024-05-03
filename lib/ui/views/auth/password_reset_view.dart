import 'package:agenda_front/constants.dart';
import 'package:agenda_front/providers.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/ui/custom_inputs.dart';
import 'package:agenda_front/ui/widgets/elevated_button.dart';
import 'package:agenda_front/ui/widgets/link_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class PasswordResetView extends StatelessWidget {
  const PasswordResetView({super.key});

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
                    ]),
                  ),
                  const SizedBox(height: defaultSizing),
                  EButton(
                    onPressed: () async {
                      if (formKey.currentState!.saveAndValidate()) {
                        final email =
                            formKey.currentState!.fields['email']!.value;
                        if (await Provider.of<UserProvider>(context,
                                listen: false)
                            .existe(email)) {
                          formKey.currentState!.fields['email']
                              ?.invalidate('Correo no disponible.');
                          return;
                        } else {
                          await provider.register(formKey.currentState!.value);
                        }
                      }
                    },
                    text: 'Solicitar cambio de contraseña',
                  ),
                  const SizedBox(height: defaultSizing),
                  LinkButton(
                    text: 'Ir al login',
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, RouterService.loginRoute);
                    },
                  )
                ],
              )),
        ),
      ),
    );
  }
}
