import 'package:agenda_front/providers.dart';
import 'package:agenda_front/ui/views/auth/login_view.dart';
import 'package:agenda_front/ui/views/grupo/grupo_form_view.dart';
import 'package:agenda_front/ui/views/grupo/grupo_index_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class GrupoHandler {
  static Handler index = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const GrupoIndexView();
    } else {
      return const LoginView();
    }
  });

  static Handler create = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const GrupoFormView();
    } else {
      return const LoginView();
    }
  });

  static Handler edit = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    final id = params['id']?.first;
    final grupo =
        Provider.of<GrupoProvider>(context, listen: false).buscar(id!);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return GrupoFormView(grupo: grupo);
    } else {
      return const LoginView();
    }
  });
}
