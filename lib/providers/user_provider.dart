import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/security/usuario.dart';
import 'package:agenda_front/services/notifications_service.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  List<Usuario> users = [];

  getUsers() async {
    try {
      final response = await AgendaAPI.httpGet('/users');
      List<Usuario> usersResponse =
          List<Usuario>.from(response.map((model) => Usuario.fromJson(model)));
      users = [...usersResponse];
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Usuario getUser(String id) {
    try {
      return users.where((element) => element.id!.contains(id)).first;
    } catch (e) {
      rethrow;
    }
  }

  Future newUser(Usuario user) async {
    final data = user.toJson();
    try {
      final json = await AgendaAPI.httpPost('/users', data);
      final usuarioNuevo = Usuario.fromJson(json);
      users.add(usuarioNuevo);
      notifyListeners();
    } catch (e) {
      throw 'Error al crear User';
    }
  }

  Future updateUser(String id, String name) async {
    final data = {'nombre': name};
    try {
      final json = await AgendaAPI.httpPut('/users/$id', data);
      final usuarioModificado = Usuario.fromJson(json);
      // Se busca el index en lista del ID User
      final index = users.indexWhere((element) => element.id!.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      users[index] = usuarioModificado;
      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar categoria';
    }
  }

  Future deleteUser(String id) async {
    try {
      final json = await AgendaAPI.httpDelete('/users/$id', {});
      final confirmado = json as bool;
      if (confirmado) {
        users.removeWhere((categoria) => categoria.id == id);
      } else {
        NotificationsService.showSnackbarError(
            'No se ha podido eliminar registro, intente nuevamente');
      }
      notifyListeners();
    } catch (e) {
      throw 'Error al eliminar categoria';
    }
  }
}
