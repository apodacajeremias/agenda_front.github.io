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
import 'package:flutter_localizations/flutter_localizations.dart';
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
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.configurePrefs();
  AgendaAPI.configureDio();
  Flurorouter.configureRoutes();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      child: const Dashboard(),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

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
      theme: theme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        SfGlobalLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('es'),
        Locale('pt'),
      ],
      locale: const Locale('es'),
    );
  }
}

// ThemeData theme = ThemeData(
//     useMaterial3: false,
//     colorScheme: ColorScheme.fromSeed(
//       seedColor: const Color(0xFF007bc2),
//       primary: const Color(0xFF00A8E0),
//       secondary: const Color(0xFF3fc1cf),
//       tertiary: const Color(0xFFa0d7da),
//       background: const Color(0xFFe0e8eb),
//       brightness: Brightness.light,
//     ),
//     inputDecorationTheme:
//         const InputDecorationTheme(border: OutlineInputBorder()),
//     fontFamily: 'Montserrat');

ThemeData theme = ThemeData(
    useMaterial3: false,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF0070cc),
      brightness: Brightness.light,
    ),
    inputDecorationTheme:
        const InputDecorationTheme(border: OutlineInputBorder()),
    fontFamily: 'Montserrat');
ThemeData darkTheme = ThemeData(
    useMaterial3: false,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      brightness: Brightness.dark,
    ),
    inputDecorationTheme:
        const InputDecorationTheme(border: OutlineInputBorder()),
    fontFamily: 'Montserrat');
