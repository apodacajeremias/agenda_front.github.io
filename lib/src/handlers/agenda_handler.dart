import 'package:agenda_front/providers.dart';
import 'package:agenda_front/ui/views/agenda/agenda_form_view.dart';
import 'package:agenda_front/ui/views/agenda/agenda_index_view.dart';
import 'package:agenda_front/ui/views/auth/login_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class AgendaHandler {
  static Handler index = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const AgendaIndexView();
    } else {
      return const LoginView();
    }
  });

  static Handler page = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const AgendaFormView();
    } else {
      return const LoginView();
    }
  });

  static Handler create = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const AgendaFormView();
    } else {
      return const LoginView();
    }
  });

  static Handler reschedule = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
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
