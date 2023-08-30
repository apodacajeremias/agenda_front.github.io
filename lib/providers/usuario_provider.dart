import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/security/usuario.dart';
import 'package:agenda_front/services/notifications_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class UsuarioProvider extends ChangeNotifier {
  List<Usuario> usuarios = [];
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  buscarTodos() async {
    final response = await AgendaAPI.httpGet('/users');
    List<Usuario> usuariosResponse =
        List<Usuario>.from(response.map((model) => Usuario.fromJson(model)));
    usuarios = [...usuariosResponse];
    notifyListeners();
  }

  Usuario? buscar(String id) {
    return usuarios.where((element) => element.id!.contains(id)).first;
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
      final usuario = Usuario.fromJson(json);
      usuarios.add(usuario);
      notifyListeners();
      NotificationsService.showSnackbar('Agregado a usuarios');
      return Future.value(usuario);
    } catch (e) {
      NotificationsService.showSnackbarError('No agregado a usuarios');
      rethrow;
    }
  }

  _actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPut('/users/$id', data);
      final usuario = Usuario.fromJson(json);
      // Buscamos el index en lista del ID Usuario
      final index = usuarios.indexWhere((element) => element.id!.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      usuarios[index] = usuario;
      notifyListeners();
      NotificationsService.showSnackbar('Usuario actualizado');
      return Future.value(usuario);
    } catch (e) {
      NotificationsService.showSnackbarError('Usuario no actualizado');
      rethrow;
    }
  }

  eliminar(String id) async {
    try {
      final json = await AgendaAPI.httpDelete('/users/$id', {});
      final confirmado = json as bool;
      if (confirmado) {
        usuarios.removeWhere((usuario) => usuario.id == id);
        notifyListeners();
        NotificationsService.showSnackbar('1 usuario eliminado');
      }
      return Future.value(confirmado);
    } catch (e) {
      NotificationsService.showSnackbarError('Usuario no eliminado');
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
