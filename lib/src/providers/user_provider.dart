import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/security/user.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  List<User> users = [];
  // GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  buscarTodos() async {
    final response = await ServerConnection.httpGet('/users');
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
      final json = await ServerConnection.httpPost('/users', data);
      final usuario = User.fromJson(json);
      users.add(usuario);
      notifyListeners();
      NotificationService.showSnackbar('Agregado a users');
      return Future.value(usuario);
    } catch (e) {
      NotificationService.showSnackbarError('No agregado a users');
      rethrow;
    }
  }

  _actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await ServerConnection.httpPut('/users/$id', data);
      final usuario = User.fromJson(json);
      // Buscamos el index en lista del ID User
      final index = users.indexWhere((element) => element.id!.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      users[index] = usuario;
      notifyListeners();
      NotificationService.showSnackbar('User actualizado');
      return Future.value(usuario);
    } catch (e) {
      NotificationService.showSnackbarError('User no actualizado');
      rethrow;
    }
  }

  eliminar(String id) async {
    try {
      final json = await ServerConnection.httpDelete('/users/$id', {});
      final confirmado = json as bool;
      if (confirmado) {
        users.removeWhere((usuario) => usuario.id == id);
        notifyListeners();
        NotificationService.showSnackbar('1 usuario eliminado');
      }
      return Future.value(confirmado);
    } catch (e) {
      NotificationService.showSnackbarError('User no eliminado');
      rethrow;
    }
  }

  existe(String email) async {
    try {
      bool r = await ServerConnection.httpGet('/users/existeEmail/$email');
      return r;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  // saveAndValidate() {
  //   return formKey.currentState!.saveAndValidate();
  // }

  // formData() {
  //   return formKey.currentState!.value;
  // }
}
