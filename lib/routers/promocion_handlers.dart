import 'package:agenda_front/providers/auth_provider.dart';
import 'package:agenda_front/providers/promocion_provider.dart';
import 'package:agenda_front/providers/sidemenu_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/ui/views/forms/promocion_form_view.dart';
import 'package:agenda_front/ui/views/indexs/promocion_index_view.dart';
import 'package:agenda_front/ui/views/login_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class PromocionHandlers {
  static Handler index = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.promocionesIndexRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const PromocionIndexView();
    } else {
      return const LoginView();
    }
  });

  static Handler create = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.promocionesIndexRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const PromocionFormView();
    } else {
      return const LoginView();
    }
  });

  static Handler edit = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.promocionesIndexRoute);
    final id = params['id']?.first;
    final promocion =
        Provider.of<PromocionProvider>(context, listen: false).buscar(id!);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return PromocionFormView(promocion: promocion);
    } else {
      return const LoginView();
    }
  });
}
