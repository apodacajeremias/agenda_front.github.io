import 'package:agenda_front/models/persona.dart';

class AuthenticationResponse {
    String token;
    Persona persona;

    AuthenticationResponse({
        required this.token,
        required this.persona,
    });

    factory AuthenticationResponse.fromJson(Map<String, dynamic> json) => AuthenticationResponse(
        token: json["token"],
        persona: Persona.fromJson(json["persona"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "persona": persona.toJson(),
    };
}

