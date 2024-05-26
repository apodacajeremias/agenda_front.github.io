import 'package:agenda_front/src/models/entities/empresa.dart';
import 'package:agenda_front/src/models/entities/persona.dart';

class AuthenticationResponse {
  String token;
  Persona persona;
  Empresa? empresa;

  AuthenticationResponse(
      {required this.token, required this.persona, this.empresa});

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      AuthenticationResponse(
          token: json['accessToken'],
          persona: Persona.fromJson(json['persona']),
          empresa: json.containsKey('empresa') && json['empresa'] != null
              ? Empresa.fromJson(json['empresa'])
              : null);
}
