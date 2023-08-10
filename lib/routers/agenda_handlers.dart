// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/providers/auth_provider.dart';
import 'package:agenda_front/providers/sidemenu_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/ui/views/forms/agenda_form_view.dart';

import 'package:agenda_front/ui/views/indexs/agenda_index_view.dart';
import 'package:agenda_front/ui/views/login_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class AgendaHandlers {
  static Handler index = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.agendasIndexRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const AgendaIndexView();
    } else {
      return const LoginView();
    }
  });

  static Handler create = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.agendasIndexRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return AgendaFormView();
    } else {
      return const LoginView();
    }
  });

  static Handler reschedule = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.agendasIndexRoute);
    final id = params['id']!.first;

    if (authProvider.authStatus == AuthStatus.authenticated) {
      // TODO: Crear view
      return null;
    } else {
      return const LoginView();
    }
  });

  static Handler unschedule = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.agendasIndexRoute);
    final id = params['id']!.first;

    if (authProvider.authStatus == AuthStatus.authenticated) {
      // TODO: Crear view
      return null;
    } else {
      return const LoginView();
    }
  });

  static Handler prioritize = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.agendasIndexRoute);
    final id = params['id']!.first;
    final prioridad = params['prioridad']!.first;

    if (authProvider.authStatus == AuthStatus.authenticated) {
      // TODO: Crear view
      return null;
    } else {
      return const LoginView();
    }
  });

  static Handler deprioritize = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.agendasIndexRoute);
    final id = params['id']!.first;
    final prioridad = params['prioridad']!.first;

    if (authProvider.authStatus == AuthStatus.authenticated) {
      // TODO: Crear view
      return null;
    } else {
      return const LoginView();
    }
  });

  static Handler changeSituation = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.agendasIndexRoute);
    final id = params['id']!.first;
    final situacion = params['situacion']!.first;

    if (authProvider.authStatus == AuthStatus.authenticated) {
      // TODO: Crear view
      return null;
    } else {
      return const LoginView();
    }
  });
}
