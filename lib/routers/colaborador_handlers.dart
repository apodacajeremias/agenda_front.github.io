import 'package:agenda_front/providers/auth_provider.dart';
import 'package:agenda_front/providers/colaborador_provider.dart';
import 'package:agenda_front/providers/sidemenu_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/ui/views/forms/colaborador_form_view.dart';
import 'package:agenda_front/ui/views/indexs/colaborador_index_view.dart';
import 'package:agenda_front/ui/views/login_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class ColaboradorHandlers {
  static Handler index = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.colaboradoresIndexRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const ColaboradorIndexView();
    } else {
      return const LoginView();
    }
  });

  static Handler create = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.colaboradoresIndexRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const ColaboradorFormView();
    } else {
      return const LoginView();
    }
  });

  static Handler edit = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.colaboradoresIndexRoute);
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
