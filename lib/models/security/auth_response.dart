import 'package:agenda_front/models/security/usuario.dart';

class AuthenticationResponse {
  String token;
  Usuario usuario;

  AuthenticationResponse({
    required this.token,
    required this.usuario,
  });

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      AuthenticationResponse(
        token: json['token'],
        usuario: Usuario.fromJson(json['usuario']),
      );
}
