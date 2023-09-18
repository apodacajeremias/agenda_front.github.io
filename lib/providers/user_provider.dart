import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/security/user.dart';
import 'package:agenda_front/services/notifications_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class UserProvider extends ChangeNotifier {
  List<User> users = [];
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  buscarTodos() async {
    final response = await AgendaAPI.httpGet('/users');
    List<User> usersResponse =
        List<User>.from(response.map((model) => User.fromJson(model)));
    users = [...usersResponse];
    notifyListeners();
  }

  User? buscar(String id) {
    return users.where((element) => element.id!.contains(id)).first;
  }

  registrar(Map<String, dynamic> data) async {
    // Si data tiene un campo ID y este tiene informacion
    if (data.containsKey('ID') && data['ID'] != null) {
      // Actualiza
      return await _actualizar(data['ID'], data);
    } else {
      return await _guardar(data);
    }
  }

  _guardar(Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPost('/users', data);
      final usuario = User.fromJson(json);
      users.add(usuario);
      notifyListeners();
      NotificationsService.showSnackbar('Agregado a users');
      return Future.value(usuario);
    } catch (e) {
      NotificationsService.showSnackbarError('No agregado a users');
      rethrow;
    }
  }

  _actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPut('/users/$id', data);
      final usuario = User.fromJson(json);
      // Buscamos el index en lista del ID User
      final index = users.indexWhere((element) => element.id!.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      users[index] = usuario;
      notifyListeners();
      NotificationsService.showSnackbar('User actualizado');
      return Future.value(usuario);
    } catch (e) {
      NotificationsService.showSnackbarError('User no actualizado');
      rethrow;
    }
  }

  eliminar(String id) async {
    try {
      final json = await AgendaAPI.httpDelete('/users/$id', {});
      final confirmado = json as bool;
      if (confirmado) {
        users.removeWhere((usuario) => usuario.id == id);
        notifyListeners();
        NotificationsService.showSnackbar('1 usuario eliminado');
      }
      return Future.value(confirmado);
    } catch (e) {
      NotificationsService.showSnackbarError('User no eliminado');
      rethrow;
    }
  }

  Future<bool> existe(String email) async {
    try {
      return await AgendaAPI.httpGet('/users/existeEmail/$email');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  saveAndValidate() {
    return formKey.currentState!.saveAndValidate();
  }

  formData() {
    return formKey.currentState!.value;
  }
}
