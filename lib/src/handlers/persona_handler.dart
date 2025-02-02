import 'package:agenda_front/providers.dart';
import 'package:agenda_front/ui/views/auth/login_view.dart';
import 'package:agenda_front/ui/views/persona/persona_form_view.dart';
import 'package:agenda_front/ui/views/persona/persona_index_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class PersonaHandler {
  static Handler index = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const PersonaIndexView();
      // return const PersonaView();
    } else {
      return const LoginView();
    }
  });

  static Handler create = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const PersonaFormView();
    } else {
      return const LoginView();
    }
  });

  static Handler edit = Handler(handlerFunc: (context, params) {
    final id = params['id']?.first;
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      // return PersonaFormView(
      //     future:
      //         Provider.of<PersonaProvider>(context, listen: false).buscar(id!));
      return PersonaFormView(id: id);
    } else {
      return const LoginView();
    }
  });
}
