import 'package:agenda_front/models/entities/empresa.dart';
import 'package:agenda_front/models/entities/persona.dart';

class AuthenticationResponse {
  String token;
  Persona? persona;
  Empresa? empresa;

  AuthenticationResponse({required this.token, this.persona, this.empresa});

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      AuthenticationResponse(
          token: json['accessToken'],
          persona: Persona.fromJson(json['persona']),
          empresa: json.containsKey('empresa') && json['empresa'] != null
              ? Empresa.fromJson(json['empresa'])
              : null);
}
