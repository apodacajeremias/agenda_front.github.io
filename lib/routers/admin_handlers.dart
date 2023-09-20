import 'package:agenda_front/providers/auth_provider.dart';
import 'package:agenda_front/ui/views/dashboard_view.dart';
import 'package:agenda_front/ui/views/forms/empresa_form_view.dart';
import 'package:agenda_front/ui/views/forms/persona_form_view.dart';
import 'package:agenda_front/ui/views/login_view.dart';
import 'package:agenda_front/ui/views/register_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class AdminHandlers {
  static Handler login = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return const LoginView();
    } else if (authProvider.authStatus == AuthStatus.notProfile) {
      return const PersonaView();
    } else if (authProvider.authStatus == AuthStatus.notConfigured) {
      return const EmpresaFormView();
    } else {
      return const DashboardView();
    }
  });

  static Handler register = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);

    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return const RegisterView();
    } else if (authProvider.authStatus == AuthStatus.notProfile) {
      return const PersonaView();
    } else if (authProvider.authStatus == AuthStatus.notConfigured) {
      return const EmpresaFormView();
    } else {
      return const DashboardView();
    }
  });

  static Handler configure = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);

    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return const LoginView();
    } else if (authProvider.authStatus == AuthStatus.notProfile) {
      return const PersonaView();
    } else if (authProvider.authStatus == AuthStatus.notConfigured) {
      return const EmpresaFormView();
    } else {
      return const DashboardView();
    }
  });
}
