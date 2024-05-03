import 'package:agenda_front/src/models/entities/persona.dart';

class User {
  String? email;
  bool? changePassword;
  String? lastPasswordChange;
  String? role;
  String? username;
  bool? accountNonExpired;
  bool? accountNonLocked;
  bool? credentialsNonExpired;
  String? id;
  bool? enabled;
  Persona? persona;
  User(
      {this.email,
      this.changePassword,
      this.lastPasswordChange,
      this.role,
      this.username,
      this.accountNonExpired,
      this.accountNonLocked,
      this.credentialsNonExpired,
      this.id,
      this.enabled,
      this.persona});

  factory User.fromJson(Map<String, dynamic> json) => User(
      email: json['email'],
      changePassword: json['changePassword'],
      lastPasswordChange: json['lastPasswordChange'],
      role: json['role'],
      username: json['username'],
      accountNonExpired: json['accountNonExpired'],
      accountNonLocked: json['accountNonLocked'],
      credentialsNonExpired: json['credentialsNonExpired'],
      id: json['id'],
      enabled: json['enabled'],
      persona: (json.containsKey('persona') && json['persona'] != null)
          ? Persona.fromJson(json['persona'])
          : null);

  Map<String, dynamic> toJson() => {
        'email': email,
        'changePassword': changePassword,
        'lastPasswordChange': lastPasswordChange,
        'role': role,
        'username': username,
        'accountNonExpired': accountNonExpired,
        'accountNonLocked': accountNonLocked,
        'credentialsNonExpired': credentialsNonExpired,
        'id': id,
        'enabled': enabled,
        'persona': persona?.toJson()
      };
}
