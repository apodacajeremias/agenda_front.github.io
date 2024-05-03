import 'package:agenda_front/extensions.dart';
import 'package:agenda_front/translate.dart';
import 'package:flutter/material.dart';

class RegistrationConfirmView extends StatelessWidget {
  const RegistrationConfirmView({super.key});

  // TODO: solicitar confirmacion y dependiendo de la respuesta mostrar confirmacion o sino error
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.registroConfirmado,
            style: context.headlineLarge,
          ),
          Text(
            AppLocalizations.of(context)!.registroConfirmadoSub,
            style: context.titleSmall,
          ),
        ],
      ),
    );
  }
}
