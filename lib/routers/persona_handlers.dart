// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/providers/auth_provider.dart';
import 'package:agenda_front/providers/persona_provider.dart';
import 'package:agenda_front/providers/sidemenu_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/services/notifications_service.dart';
import 'package:agenda_front/ui/views/forms/persona_form_view.dart';
import 'package:agenda_front/ui/views/indexs/persona_index_view.dart';
import 'package:agenda_front/ui/views/login_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class PersonaHandlers {
  static Handler index = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.personasIndexRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const PersonaIndexView();
    } else {
      return const LoginView();
    }
  });

  static Handler crear = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.personasIndexRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return PersonaFormView();
    } else {
      return const LoginView();
    }
  });

  static Handler editar = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.personasIndexRoute);
    final id = params['id']!.first;

    if (id.isEmpty) {
      NavigationService.replaceTo(Flurorouter.personasIndexRoute);
      NotificationsService.showSnackbar('No se ha encontrado registro');
    }

    final editar = Provider.of<PersonaProvider>(context).buscar(id);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return PersonaFormView(persona: editar);
    } else {
      return const LoginView();
    }
  });
}
