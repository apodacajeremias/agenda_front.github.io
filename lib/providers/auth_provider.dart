import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/entities/colaborador.dart';
import 'package:agenda_front/models/entities/empresa.dart';
import 'package:agenda_front/models/entities/persona.dart';
import 'package:agenda_front/models/security/auth_response.dart';
import 'package:agenda_front/models/security/usuario.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/services/local_storage.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/services/notifications_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  String? _token;
  Usuario? usuario;
  Persona? persona;
  Colaborador? colaborador;
  Empresa? empresa;
  AuthStatus _authStatus = AuthStatus.checking;
  GlobalKey<FormBuilderState> registerKey = GlobalKey<FormBuilderState>();
  GlobalKey<FormBuilderState> loginKey = GlobalKey<FormBuilderState>();

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

  registrar(Map<String, dynamic> data) {
    AgendaAPI.httpPost('/auth/register', data).then((json) {
      final authResponse = AuthenticationResponse.fromJson(json);
      _token = authResponse.token;
      usuario = authResponse.usuario;
      persona = authResponse.usuario.persona;
      colaborador = authResponse.usuario.persona?.colaborador;
      empresa = authResponse.empresa;
      _authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', _token!);
      NavigationService.replaceTo(Flurorouter.dashboardRoute);
      notifyListeners();
    }).catchError((e) {
      LocalStorage.prefs.remove('token');
      NotificationsService.showSnackbarError('No se ha registrado, reintente.');
      throw e;
    });
  }

  login(Map<String, dynamic> data) {
    AgendaAPI.httpPost('/auth/login', data).then((json) {
      final authResponse = AuthenticationResponse.fromJson(json);
      _token = authResponse.token;
      usuario = authResponse.usuario;
      persona = authResponse.usuario.persona;
      colaborador = authResponse.usuario.persona?.colaborador;
      empresa = authResponse.empresa;
      _authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', _token!);
      // NavigationService.replaceTo(Flurorouter.dashboardRoute);
      notifyListeners();
    }).catchError((e) {
      LocalStorage.prefs.remove('token');
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
          '/auth/validate/${LocalStorage.prefs.getString('token')}');
      final authResponse = AuthenticationResponse.fromJson(resp);
      _token = authResponse.token;
      usuario = authResponse.usuario;
      persona = authResponse.usuario.persona;
      colaborador = authResponse.usuario.persona?.colaborador;
      empresa = authResponse.empresa;
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

  saveAndValidateRegister() {
    return registerKey.currentState!.saveAndValidate();
  }

  saveAndValidateLogin() {
    return loginKey.currentState!.saveAndValidate();
  }

  formDataRegister() {
    return registerKey.currentState!.value;
  }

  formDataLogin() {
    return loginKey.currentState!.value;
  }
}
