// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/models/persona.dart';
import 'package:agenda_front/providers/auth_provider.dart';
import 'package:agenda_front/providers/persona_provider.dart';
import 'package:agenda_front/providers/sidemenu_provider.dart';
import 'package:agenda_front/routers/router.dart';
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

  static Handler create = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.personasIndexRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return PersonaFormView(persona: Persona(),);
    } else {
      return const LoginView();
    }
  });

  static Handler edit = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.personasIndexRoute);
    final id = params['id']!.first;

    Persona editar = Provider.of<PersonaProvider>(context).getPersona(id);
    print(id);
    print(editar.toString());
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return PersonaFormView(persona: editar);
    } else {
      return const LoginView();
    }
  });
}
