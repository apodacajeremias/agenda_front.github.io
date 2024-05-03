import 'package:agenda_front/providers.dart';
import 'package:agenda_front/ui/views/auth/login_view.dart';
import 'package:agenda_front/ui/views/beneficio/beneficio_form_view.dart';
import 'package:agenda_front/ui/views/beneficio/beneficio_index_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class BeneficioHandler {
  static Handler index = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const BeneficioIndexView();
    } else {
      return const LoginView();
    }
  });

  static Handler create = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const BeneficioFormView();
    } else {
      return const LoginView();
    }
  });

  static Handler edit = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    final id = params['id']?.first;
    final beneficio =
        Provider.of<BeneficioProvider>(context, listen: false).buscar(id!);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return BeneficioFormView(beneficio: beneficio);
    } else {
      return const LoginView();
    }
  });
}
