// To parse this JSON data, do
//
//     final usersResponse = usersResponseFromMap(jsonString);
import 'dart:convert';

import 'package:agenda_front/models/user.dart';

class UsersResponse {
  UsersResponse({
    required this.total,
    required this.users,
  });

  int total;
  List<User> users;

  factory UsersResponse.fromJson(String str) =>
      UsersResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsersResponse.fromMap(Map<String, dynamic> json) => UsersResponse(
        total: json["total"],
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toMap() => {
        "total": total,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}
