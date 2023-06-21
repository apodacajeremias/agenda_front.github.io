import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/persona.dart';
import 'package:agenda_front/models/security/auth_response.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/services/local_storage.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/services/notifications_service.dart';
import 'package:flutter/material.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  String? _token;
  Persona? persona;
  AuthStatus authStatus = AuthStatus.checking;

  AuthProvider() {
    isAuthenticated();
  }

//TODO; recibir un model Persona
  register(String email, String password, String name) {
    final data = {'nombre': name, 'correo': email, 'password': password};
    AgendaAPI.httpPost('/auth/register', data).then((json) {
      final authResponse = AuthenticationResponse.fromJson(json);
      _token = authResponse.token;
      persona = authResponse.persona;
      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', _token!);
      NavigationService.replaceTo(Flurorouter.dashboardRoute);
      AgendaAPI.configureDio();
      notifyListeners();
    }).catchError((e) {
      print('error en register: $e');
      NotificationsService.showSnackbarError('Usuario / Password no válidos');
    });
  }

  login(String email, String password) {
    final data = {'email': email, 'password': password};
    AgendaAPI.httpPost('/auth/login', data).then((json) {
      final authResponse = AuthenticationResponse.fromJson(json);
      _token = authResponse.token;
      persona = authResponse.persona;
      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', _token!);
      NavigationService.replaceTo(Flurorouter.dashboardRoute);
      AgendaAPI.configureDio();
      notifyListeners();
    }).catchError((e) {
      print('Error en login: $e');
      NotificationsService.showSnackbarError('Usuario / Password no válido');
    });
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString('token');
    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      NotificationsService.showSnackbarError(
          'Sesion expirada, ingrese credenciales nuevamente');
      return false;
    }
    final data = {'token': token};
    AgendaAPI.httpPost('/auth/validate', data).then((json) {
      if (json == null) {
        authStatus = AuthStatus.notAuthenticated;
        return false;
      } else {
        final authResponse = AuthenticationResponse.fromJson(json);
        _token = authResponse.token;
        persona = authResponse.persona;
        authStatus = AuthStatus.authenticated;
        LocalStorage.prefs.setString('token', _token!);
        NavigationService.replaceTo(Flurorouter.dashboardRoute);
        AgendaAPI.configureDio();
        notifyListeners();
      }
    }).catchError((e) {
      print("Error en isAuthenticated: $e");
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      NotificationsService.showSnackbarError(
          'ERROR al verificar sesion, ingrese nuevamente');
      return false;
    });
    return false;
  }

  logout() {
    AgendaAPI.httpGet('/auth/logout').then((value) {
      LocalStorage.prefs.remove('token');
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
    }).catchError((e) {});
  }
}
