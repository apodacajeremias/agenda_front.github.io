import 'package:agenda_front/providers.dart';
import 'package:agenda_front/ui/views/auth/login_view.dart';
import 'package:agenda_front/ui/views/colaborador/colaborador_form_view.dart';
import 'package:agenda_front/ui/views/colaborador/colaborador_index_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class ColaboradorHandler {
  static Handler index = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const ColaboradorIndexView();
    } else {
      return const LoginView();
    }
  });

  static Handler create = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const ColaboradorFormView();
    } else {
      return const LoginView();
    }
  });

  static Handler edit = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    final id = params['id']?.first;
    final colaborador =
        Provider.of<ColaboradorProvider>(context, listen: false).buscar(id!);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return ColaboradorFormView(colaborador: colaborador);
    } else {
      return const LoginView();
    }
  });
}
