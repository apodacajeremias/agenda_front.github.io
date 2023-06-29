import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/security/auth_response.dart';
import 'package:agenda_front/models/security/user.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/services/local_storage.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/services/notifications_service.dart';
import 'package:flutter/foundation.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  String? _token;
  User? user;
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
      user = authResponse.user;
      _authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', _token!);
      NavigationService.replaceTo(Flurorouter.dashboardRoute);
      AgendaAPI.configureDio();
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
      user = authResponse.user;
      _authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', _token!);
      NavigationService.replaceTo(Flurorouter.dashboardRoute);
      AgendaAPI.configureDio();
      notifyListeners();
    }).catchError((e) {
      if (kDebugMode) {
        print('Error en login: $e');
      }
      NotificationsService.showSnackbarError('Usuario / Password no válido');
    });
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString('token');

    if (token == null) {
      _authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    try {
      final resp = await AgendaAPI.httpGet('/auth/validate?token=$token');
      final authReponse = AuthenticationResponse.fromJson(resp);
      LocalStorage.prefs.setString('token', authReponse.token);

      user = authReponse.user;
      _authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      LocalStorage.prefs.remove('token');
      _authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
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
