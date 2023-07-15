// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/providers/auth_provider.dart';
import 'package:agenda_front/providers/agenda_provider.dart';
import 'package:agenda_front/providers/sidemenu_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/services/notifications_service.dart';

import 'package:agenda_front/ui/views/indexs/agenda_index_view.dart';
import 'package:agenda_front/ui/views/login_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class AgendaHandlers {
  static Handler index = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.agendasIndexRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const AgendaIndexView();
    } else {
      return const LoginView();
    }
  });

  static Handler create = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.agendasIndexRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return null;
    } else {
      return const LoginView();
    }
  });

  static Handler reschedule = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.agendasIndexRoute);
    final id = params['id']!.first;

    if (id.isEmpty) {
      NavigationService.replaceTo(Flurorouter.agendasIndexRoute);
      NotificationsService.showSnackbar('No se ha encontrado registro');
    }

    final editar = Provider.of<AgendaProvider>(context).buscar(id);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return null;
    } else {
      return const LoginView();
    }
  });
}
