import 'package:agenda_front/models/persona.dart';
import 'package:flutter/material.dart';

class PersonaFormView extends StatefulWidget {
  final Persona persona;

  const PersonaFormView({super.key, required this.persona});  

  @override
  State<PersonaFormView> createState() => _PersonaFormViewState();
}

class _PersonaFormViewState extends State<PersonaFormView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
