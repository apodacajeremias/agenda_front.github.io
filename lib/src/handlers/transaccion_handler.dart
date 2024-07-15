import 'package:agenda_front/providers.dart';
import 'package:agenda_front/ui/views/auth/login_view.dart';
import 'package:agenda_front/ui/views/transaccion/transaccion_form_view.dart';
import 'package:agenda_front/ui/views/transaccion/transaccion_index_view.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
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
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return FutureBuilder(
        future: Provider.of<TransaccionFormProvider>(context, listen: false)
            .buscar(id!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return TransaccionFormView(transaccion: snapshot.data);
          }
          return const SizedBox.square(
            dimension: 200,
            child: CircularProgressIndicator.adaptive(),
          );
        },
      );
    } else {
      return const LoginView();
    }
  });
}
