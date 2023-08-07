import 'dart:convert';

import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/providers/agenda_provider.dart';
import 'package:agenda_front/providers/beneficio_provider.dart';
import 'package:agenda_front/providers/colaborador_provider.dart';
import 'package:agenda_front/providers/empresa_provider.dart';
import 'package:agenda_front/providers/grupo_provider.dart';
import 'package:agenda_front/providers/item_provider.dart';
import 'package:agenda_front/providers/persona_provider.dart';
import 'package:agenda_front/providers/promocion_provider.dart';
import 'package:agenda_front/providers/transaccion_provider.dart';
import 'package:agenda_front/providers/usuario_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';
import 'package:provider/provider.dart';

import 'package:agenda_front/ui/layouts/dashboard/dashboard_layout.dart';
import 'package:agenda_front/ui/layouts/splash/splash_layout.dart';

import 'package:agenda_front/routers/router.dart';

import 'package:agenda_front/providers/auth_provider.dart';
import 'package:agenda_front/providers/sidemenu_provider.dart';

import 'package:agenda_front/services/local_storage.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/services/notifications_service.dart';

import 'package:agenda_front/ui/layouts/auth/auth_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;
  await LocalStorage.configurePrefs();
  AgendaAPI.configureDio();
  Flurorouter.configureRoutes();
  runApp(MyApp(theme: theme));
}

class MyApp extends StatelessWidget {
  final ThemeData theme;
  const MyApp({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => AuthProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => SideMenuProvider()),
        // MANEJADORES DE LOS MODELOS
        ChangeNotifierProvider(create: (_) => AgendaProvider()),
        ChangeNotifierProvider(create: (_) => BeneficioProvider()),
        ChangeNotifierProvider(create: (_) => ColaboradorProvider()),
        ChangeNotifierProvider(create: (_) => EmpresaProvider()),
        ChangeNotifierProvider(create: (_) => GrupoProvider()),
        ChangeNotifierProvider(create: (_) => ItemProvider()),
        ChangeNotifierProvider(create: (_) => PersonaProvider()),
        ChangeNotifierProvider(create: (_) => PromocionProvider()),
        ChangeNotifierProvider(create: (_) => TransaccionProvider()),
        ChangeNotifierProvider(create: (_) => UsuarioProvider()),
      ],
      child: Dashboard(theme: theme),
    );
  }
}

class Dashboard extends StatelessWidget {
  final ThemeData theme;
  const Dashboard({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: true,
        title: 'Inicio',
        initialRoute: '/',
        onGenerateRoute: Flurorouter.router.generator,
        navigatorKey: NavigationService.navigatorKey,
        scaffoldMessengerKey: NotificationsService.messengerKey,
        builder: (_, child) {
          final authProvider = Provider.of<AuthProvider>(context);

          if (authProvider.authStatus == AuthStatus.checking) {
            return const SplashLayout();
          }

          if (authProvider.authStatus == AuthStatus.authenticated) {
            return DashboardLayout(child: child!);
          } else {
            return AuthLayout(child: child!);
          }
        },
        theme: lightThemeData);
  }
}

ThemeData lightThemeData = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    primary: Colors.blueAccent,
    secondary: Colors.yellow,
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.blue,
    //other options
  ),
);
