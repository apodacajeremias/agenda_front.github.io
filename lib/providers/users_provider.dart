import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/http/users_response.dart';
import 'package:agenda_front/models/user.dart';
import 'package:flutter/material.dart';

class UsersProvider extends ChangeNotifier {
  List<User> users = [];

  getUsers() async {
    final response = await AgendaAPI.httpGet('/users');
    final usersResponse = UsersResponse.fromMap(response);
    users = [...usersResponse.users];
    notifyListeners();
  }

  Future newUser(String name) async {
    final data = {'nombre': name};
    try {
      final json = await AgendaAPI.httpPost('/users', data);
      final newUser = User.fromJson(json);
      users.add(newUser);
      notifyListeners();
    } catch (e) {
      throw 'Error al crear categoria';
    }
  }

  Future updateUser(String id, String name) async {
    final data = {'nombre': name};
    try {
      final json = await AgendaAPI.httpPut('/users/$id', data);
      users = users.map((user) {
        if (user.id != id) return user;
        user.username = name;
        return user;
      }).toList();
      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar categoria';
    }
  }

  Future deleteUser(String id) async {
    try {
      final json = await AgendaAPI.httpDelete('/users/$id', {});

      users.removeWhere((categoria) => categoria.id == id);

      notifyListeners();
    } catch (e) {
      throw 'Error al eliminar categoria';
    }
  }
}
