import 'package:agenda_front/models/entities/empresa.dart';
import 'package:agenda_front/models/security/user.dart';

class AuthenticationResponse {
  String token;
  User user;
  Empresa? empresa;

  AuthenticationResponse(
      {required this.token, required this.user, this.empresa});

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      AuthenticationResponse(
          token: json['accessToken'],
          user: User.fromJson(json['user']),
          empresa: json.containsKey('empresa') && json['empresa'] != null
              ? Empresa.fromJson(json['empresa'])
              : null);
}
