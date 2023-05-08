import 'dart:convert';

import 'package:agenda_front/models/persona.dart';
import 'package:agenda_front/models/user.dart';

class Auth {
  Persona persona;
  User user;
  String token;

  Auth({
    required this.persona,
    required this.user,
    required this.token,
  });

  factory Auth.fromJson(String str) =>
      Auth.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Auth.fromMap(Map<String, dynamic> json) => Auth(
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
