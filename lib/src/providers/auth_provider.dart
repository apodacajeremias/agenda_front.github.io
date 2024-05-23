import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/entities/empresa.dart';
import 'package:agenda_front/src/models/entities/persona.dart';
import 'package:agenda_front/src/models/security/auth_response.dart';
import 'package:agenda_front/src/models/security/user.dart';
import 'package:flutter/material.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  String? _token;
  AuthStatus authStatus = AuthStatus.checking;
  User? user;
  Persona? persona;
  Empresa? empresa;

  AuthProvider() {
    isAuthenticated();
  }

  register(Map<String, dynamic> data) async {
    await ServerConnection.httpPost('/auth/register', data).then((json) {
      _login(json);
      notifyListeners();
    }).catchError((e) {
      LocalStorage.prefs.remove('token');
      NotificationService.showSnackbarError('No se ha registrado, reintente.');
      throw e;
    });
  }

  authenticate(Map<String, dynamic> data) {
    ServerConnection.httpPost('/auth/authenticate', data).then((json) {
      _login(json);
      notifyListeners();
      NotificationService.showSnackbar('Bienvenido');
    }).catchError((e) {
      LocalStorage.prefs.remove('token');
      NotificationService.showSnackbarError('Usuario o Contraseña no válido');
      throw e;
    });
  }

  completeConfiguration(Map<String, dynamic> data) async {
    await ServerConnection.httpPost('/auth/complete/configuration', data);
    await isAuthenticated();
  }

  completeProfile(String idUser, Map<String, dynamic> data) async {
    await ServerConnection.httpPost('/auth/complete/$idUser/profile', data);
    await isAuthenticated();
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString('token');

    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    try {
      final json = await ServerConnection.httpGet('/auth/$token');
      _login(json);
      notifyListeners();
      return true;
    } catch (e) {
      logout();
      return false;
    }
  }

  logout() async {
    await ServerConnection.httpGet('/auth/logout').then((value) {
      LocalStorage.prefs.remove('token');
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
    }).catchError((e) {
      LocalStorage.prefs.remove('token');
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
    });
  }

  _login(json) {
    final authResponse = AuthenticationResponse.fromJson(json);
    _token = authResponse.token;
    user = authResponse.user;
    persona = authResponse.user.persona;
    empresa = authResponse.empresa;
    authStatus = AuthStatus.authenticated;
    NavigationService.replaceTo(RouterService.rootRoute);
    LocalStorage.prefs.setString('token', _token!);
  }
}
