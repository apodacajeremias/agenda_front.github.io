import 'package:agenda_front/src/models/security/role.dart';

class User {
  String? email;
  bool? changePassword;
  String? lastPasswordChange;
  Role? role;
  String? username;
  bool? accountNonExpired;
  bool? accountNonLocked;
  bool? credentialsNonExpired;
  String? id;
  bool? enabled;
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
      this.enabled});

  factory User.fromJson(Map<String, dynamic> json) => User(
      email: json['email'],
      changePassword: json['changePassword'],
      lastPasswordChange: json['lastPasswordChange'],
      role: Role.values.byName(json['role']),
      username: json['username'],
      accountNonExpired: json['accountNonExpired'],
      accountNonLocked: json['accountNonLocked'],
      credentialsNonExpired: json['credentialsNonExpired'],
      id: json['id'],
      enabled: json['enabled']);

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
        'enabled': enabled
      };
}
