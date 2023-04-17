import 'dart:convert';

import 'package:agenda_front/models/persona.dart';
import 'package:agenda_front/models/user.dart';

class AuthResponse {
  Persona persona;
  User user;
  String token;

  AuthResponse({
    required this.persona,
    required this.user,
    required this.token,
  });

  factory AuthResponse.fromJson(String str) =>
      AuthResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthResponse.fromMap(Map<String, dynamic> json) => AuthResponse(
        persona: Persona.fromJson(json["persona"]),
        user: User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "persona": persona.toJson(),
        "user": user.toJson(),
        "token": token,
      };
}
