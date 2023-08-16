import 'package:agenda_front/providers/auth_provider.dart';
import 'package:agenda_front/providers/grupo_provider.dart';
import 'package:agenda_front/providers/sidemenu_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/ui/views/forms/grupo_form_view.dart';
import 'package:agenda_front/ui/views/indexs/grupo_index_view.dart';
import 'package:agenda_front/ui/views/login_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class GrupoHandlers {
  static Handler index = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.gruposIndexRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const GrupoIndexView();
    } else {
      return const LoginView();
    }
  });

  static Handler create = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.gruposIndexRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const GrupoFormView();
    } else {
      return const LoginView();
    }
  });

  static Handler edit = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.gruposIndexRoute);
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
