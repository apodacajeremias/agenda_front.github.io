import 'package:agenda_front/providers.dart';
import 'package:agenda_front/ui/views/auth/login_view.dart';
import 'package:agenda_front/ui/views/movimiento/movimiento_form_view.dart';
import 'package:agenda_front/ui/views/movimiento/movimiento_index_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class MovimientoHandler {
  static Handler index = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const MovimientoIndexView();
    } else {
      return const LoginView();
    }
  });

  static Handler create = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const MovimientoFormView();
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
      return const MovimientoFormView();
    } else {
      return const LoginView();
    }
  });
}
