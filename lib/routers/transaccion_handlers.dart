import 'package:agenda_front/providers/auth_provider.dart';
import 'package:agenda_front/providers/transaccion_provider.dart';
import 'package:agenda_front/providers/sidemenu_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/ui/views/forms/transaccion_form_view.dart';
import 'package:agenda_front/ui/views/indexs/transaccion_index_view.dart';
import 'package:agenda_front/ui/views/login_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class TransaccionHandlers {
  static Handler index = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.transaccionesIndexRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const TransaccionIndexView();
    } else {
      return const LoginView();
    }
  });

  static Handler create = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.transaccionesIndexRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const TransaccionFormView();
    } else {
      return const LoginView();
    }
  });

  static Handler edit = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.transaccionesIndexRoute);
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
