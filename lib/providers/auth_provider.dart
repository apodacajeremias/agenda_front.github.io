import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/http/auth_response.dart';
import 'package:agenda_front/models/persona.dart';
import 'package:agenda_front/models/user.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/services/local_storage.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/services/notifications_service.dart';
import 'package:flutter/material.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  String? _token;
  AuthStatus authStatus = AuthStatus.checking;
  User? user;
  Persona? persona;

  AuthProvider() {
    isAuthenticated();
  }

  login(String email, String password) {
    final data = {'email': email, 'password': password};
    AgendaAPI.httpPost('/auth/authenticate', data).then((json) {
      final authResponse = AuthResponse.fromMap(json);
      user = authResponse.user;
      persona = authResponse.persona;
      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', authResponse.token);
      NavigationService.replaceTo(Flurorouter.dashboardRoute);
      AgendaAPI.configureDio();
      notifyListeners();
    }).catchError((e) {
      print('Error en login: $e');
      NotificationsService.showSnackbarError('Usuario / Password no válido');
    });
  }

  register(String email, String password, String name) {
    final data = {'nombre': name, 'correo': email, 'password': password};

    AgendaAPI.httpPost('/usuarios', data).then((json) {
      final authResponse = AuthResponse.fromMap(json);
      user = authResponse.user;
      persona = authResponse.persona;
      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', authResponse.token);
      NavigationService.replaceTo(Flurorouter.dashboardRoute);

      AgendaAPI.configureDio();
      notifyListeners();
    }).catchError((e) {
      print('error en register: $e');
      NotificationsService.showSnackbarError('Usuario / Password no válidos');
    });
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString('token');

    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    try {
      final data = {'token': token};
      final resp = await AgendaAPI.httpPost('/auth', data);
      final authResponse = AuthResponse.fromMap(resp);
      LocalStorage.prefs.setString('token', authResponse.token);

      user = authResponse.user;
      persona = authResponse.persona;
      authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      print("Error en isAuthenticated: $e");
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
  }

  logout() {
     final resp = AgendaAPI.httpGet('/auth/logout');
    LocalStorage.prefs.remove('token');
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }
}
