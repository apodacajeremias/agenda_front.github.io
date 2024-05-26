import 'package:agenda_front/src/providers/auth_provider.dart';
import 'package:agenda_front/ui/views/auth/login_view.dart';
import 'package:agenda_front/ui/views/auth/registration_view.dart.dart';
import 'package:agenda_front/ui/views/dashboard_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class AuthHandler {
  static Handler login = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return const LoginView();
    } else {
      return const DashboardView();
    }
  });

  static Handler register = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);

    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return const RegistrationView();
    } else {
      return const DashboardView();
    }
  });
}
