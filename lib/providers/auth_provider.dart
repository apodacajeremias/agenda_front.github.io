import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/entities/persona.dart';
import 'package:agenda_front/models/security/auth_response.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/services/local_storage.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/services/notifications_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  String? _token;
  AuthStatus authStatus = AuthStatus.checking;
  Persona? persona;

  AuthProvider() {
    isAuthenticated();
  }

  register(Map<String, dynamic> data) {
    AgendaAPI.httpPost('/auth/register', data).then((json) {
      final authResponse = AuthenticationResponse.fromJson(json);
      _token = authResponse.token;
      persona = authResponse.user.persona;
      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', _token!);
      NavigationService.replaceTo(Flurorouter.dashboardRoute);
      notifyListeners();
    }).catchError((e) {
      LocalStorage.prefs.remove('token');
      NotificationsService.showSnackbarError('No se ha registrado, reintente.');
      throw e;
    });
  }

  authenticate(Map<String, dynamic> data) {
    AgendaAPI.httpPost('/auth/authenticate', data).then((json) {
      final authResponse = AuthenticationResponse.fromJson(json);
      _token = authResponse.token;
      persona = authResponse.user.persona;
      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', _token!);
      notifyListeners();
      NotificationsService.showSnackbar('Bienvenido');
    }).catchError((e) {
      LocalStorage.prefs.remove('token');
      NotificationsService.showSnackbarError('Usuario o Contraseña no válido');
      throw e;
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
      final resp = await AgendaAPI.httpGet('/auth/$token');
      final authResponse = AuthenticationResponse.fromJson(resp);
      LocalStorage.prefs.setString('token', authResponse.token);

      persona = authResponse.user.persona;
      authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
  }

  logout() {
    AgendaAPI.httpGet('/auth/logout').then((value) {
      LocalStorage.prefs.remove('token');
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
    }).catchError((e) {
      LocalStorage.prefs.remove('token');
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
    });
  }
}
