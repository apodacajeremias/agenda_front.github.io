import 'package:agenda_front/providers/auth_provider.dart';
import 'package:agenda_front/providers/sidemenu_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/ui/views/login_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class ColaboradorHandlers {
  static Handler index = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!, listen: false);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.colaboradoresIndexRoute);
      if (authProvider.authStatus == AuthStatus.authenticated) {
        // TODO: crear view
        return null;
      } else {
        return const LoginView();
      }
    },
  );

  static Handler create = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!, listen: false);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.colaboradoresIndexRoute);
      if (authProvider.authStatus == AuthStatus.authenticated) {
        // TODO: crear view
        return null;
      } else {
        return const LoginView();
      }
    },
  );

  static Handler edit = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!, listen: false);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.colaboradoresIndexRoute);

      final id = parameters['id']!.first;

      if (authProvider.authStatus == AuthStatus.authenticated) {
        // TODO: crear view
        return null;
      } else {
        return const LoginView();
      }
    },
  );
}
