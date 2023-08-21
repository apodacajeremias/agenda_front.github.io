import 'package:agenda_front/models/entities/empresa.dart';
import 'package:agenda_front/models/security/usuario.dart';

class AuthenticationResponse {
  String token;
  Usuario usuario;
  Empresa? empresa;

  AuthenticationResponse(
      {required this.token, required this.usuario, this.empresa});

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      AuthenticationResponse(
          token: json['token'],
          usuario: Usuario.fromJson(json['usuario']),
          empresa: json.containsKey('empresa') && json['empresa'] != null
              ? Empresa.fromJson(json['empresa'])
              : null);
}
