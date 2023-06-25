import 'package:agenda_front/models/security/user.dart';

class AuthenticationResponse {
    String token;
    User user;

    AuthenticationResponse({
        required this.token,
        required this.user,
    });

    factory AuthenticationResponse.fromJson(Map<String, dynamic> json) => AuthenticationResponse(
        token: json["token"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
    };
}

