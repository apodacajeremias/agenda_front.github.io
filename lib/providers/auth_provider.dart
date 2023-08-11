import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/security/auth_response.dart';
import 'package:agenda_front/models/security/usuario.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/services/local_storage.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/services/notifications_service.dart';
import 'package:flutter/foundation.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  String? _token;
  Usuario? usuario;
  AuthStatus _authStatus = AuthStatus.checking;

  AuthStatus get authStatus {
    if (kDebugMode) {
      print('GET $_authStatus');
    }
    return _authStatus;
  }

  set authStatus(AuthStatus status) {
    if (kDebugMode) {
      print('SET $status');
    }
    _authStatus = status;
    if (_authStatus == AuthStatus.notAuthenticated) {
      LocalStorage.prefs.remove('token');
    }
  }

  AuthProvider() {
    isAuthenticated();
  }

//TODO; recibir un model Persona
  register(String email, String password, String name) {
    final data = {'nombre': name, 'correo': email, 'password': password};
    AgendaAPI.httpPost('/auth/register', data).then((json) {
      final authResponse = AuthenticationResponse.fromJson(json);
      _token = authResponse.token;
      usuario = authResponse.usuario;
      _authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', _token!);
      NavigationService.replaceTo(Flurorouter.dashboardRoute);
      notifyListeners();
    }).catchError((e) {
      if (kDebugMode) {
        print('error en register: $e');
      }
      NotificationsService.showSnackbarError('Usuario / Password no válidos');
    });
  }

  login(String email, String password) {
    final data = {'email': email, 'password': password};
    AgendaAPI.httpPost('/auth/login', data).then((json) {
      final authResponse = AuthenticationResponse.fromJson(json);
      _token = authResponse.token;
      usuario = authResponse.usuario;
      _authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', _token!);
      NavigationService.replaceTo(Flurorouter.dashboardRoute);

      notifyListeners();
    }).catchError((e) {
      NotificationsService.showSnackbarError('Usuario / Password no válido');
      throw e;
    });
  }

  isAuthenticated() async {
    if (!LocalStorage.prefs.containsKey('token') ||
        LocalStorage.prefs.getString('token') == null) {
      _authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return;
    }
    try {
      final resp = await AgendaAPI.httpGet(
          '/auth/validate?token=${LocalStorage.prefs.getString('token')}');
      final authResponse = AuthenticationResponse.fromJson(resp);
      _token = authResponse.token;
      usuario = authResponse.usuario;
      _authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', _token!);
      notifyListeners();
    } catch (e) {
      LocalStorage.prefs.remove('token');
      _authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
    }
  }

  logout() {
    AgendaAPI.httpGet('/auth/logout').then((value) {
      LocalStorage.prefs.remove('token');
      _authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
    }).catchError((e) {});
  }
}
