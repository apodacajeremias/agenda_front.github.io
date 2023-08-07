import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Asigna el inicio de un nuevo contexto
  static navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  // Para mantener el context y poder volver atras segun contexto
  static replaceTo(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }
}
