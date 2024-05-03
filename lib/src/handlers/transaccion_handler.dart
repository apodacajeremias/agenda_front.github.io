import 'package:agenda_front/providers.dart';
import 'package:agenda_front/ui/views/auth/login_view.dart';
import 'package:agenda_front/ui/views/transaccion/transaccion_form_view.dart';
import 'package:agenda_front/ui/views/transaccion/transaccion_index_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class TransaccionHandler {
  static Handler index = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const TransaccionIndexView();
    } else {
      return const LoginView();
    }
  });

  static Handler create = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const TransaccionFormView();
    } else {
      return const LoginView();
    }
  });

  static Handler edit = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    final id = params['id']?.first;
    final transaccion =
        Provider.of<TransaccionProvider>(context, listen: false).buscar(id!);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return TransaccionFormView(transaccion: transaccion);
    } else {
      return const LoginView();
    }
  });
}
