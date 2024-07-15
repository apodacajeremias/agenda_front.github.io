import 'package:agenda_front/providers.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/translate.dart';
import 'package:agenda_front/ui/pages/auth_page.dart';
import 'package:agenda_front/ui/pages/dashboard_page.dart';
import 'package:agenda_front/ui/pages/splash_page.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:provider/provider.dart';

//TODO: Llenar en archivo .arb con las etiquetas y sus traducciones
void main() async {
  usePathUrlStrategy();
  // Configurar cache
  await LocalStorage.configurePrefs();
  // Configurar conexion con servidor
  ServerConnection.configureDio();
  // Configure paths
  RouterService.configure();
  // Run the app.
  runApp(const BlocsProviders());
}

class BlocsProviders extends StatelessWidget {
  const BlocsProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => AuthProvider()),
        ChangeNotifierProvider(lazy: true, create: (_) => AgendaFormProvider()),
        ChangeNotifierProvider(
            lazy: true, create: (_) => AgendaDetalleProvider()),
        ChangeNotifierProvider(
            lazy: true, create: (_) => AgendaIndexProvider()),
        ChangeNotifierProvider(lazy: true, create: (_) => BeneficioProvider()),
        ChangeNotifierProvider(
            lazy: true, create: (_) => ColaboradorProvider()),
        ChangeNotifierProvider(lazy: true, create: (_) => EmpresaProvider()),
        ChangeNotifierProvider(lazy: true, create: (_) => GrupoProvider()),
        ChangeNotifierProvider(lazy: true, create: (_) => ItemProvider()),
        ChangeNotifierProvider(
            lazy: true, create: (_) => MovimientoFormProvider()),
        ChangeNotifierProvider(
            lazy: true, create: (_) => MovimientoIndexProvider()),
        ChangeNotifierProvider(
            lazy: true, create: (_) => MovimientoDetalleProvider()),
        ChangeNotifierProvider(lazy: true, create: (_) => PersonaProvider()),
        ChangeNotifierProvider(lazy: true, create: (_) => PromocionProvider()),
        ChangeNotifierProvider(
            lazy: true, create: (_) => TransaccionFormProvider()),
        ChangeNotifierProvider(
            lazy: true, create: (_) => TransaccionIndexProvider()),
        ChangeNotifierProvider(
            lazy: true, create: (_) => TransaccionDetalleProvider()),
        ChangeNotifierProvider(lazy: true, create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    );
  }
}

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController(),
      child: MaterialApp(
        initialRoute: '/',
        // Providing a restorationScopeId allows the Navigator built by the
        // MaterialApp to restore the navigation stack when a user leaves and
        // returns to the app after it has been killed while running in the
        // background.
        restorationScopeId: 'app',

        // Provide the generated AppLocalizations to the MaterialApp. This
        // allows descendant Widgets to display the correct translations
        // depending on the user's locale.
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('es', ''), // Español, sin código de pais
        ],

        // Use AppLocalizations to configure the correct application title
        // depending on the user's locale.
        //
        // The appTitle is defined in .arb files found in the localization
        // directory.
        onGenerateTitle: (BuildContext context) =>
            AppLocalizations.of(context)!.appTitle,

        // Define a light and dark color theme. Then, read the user's
        // preferred ThemeMode (light, dark, or system default) from the
        // SettingsController to display the correct theme.
        theme: ThemeData(
          fontFamily: 'Lato',
          useMaterial3: false,
          inputDecorationTheme:
              const InputDecorationTheme(border: OutlineInputBorder()),
        ),
        darkTheme: ThemeData.dark(),
        // themeMode: settingsController.themeMode,

        // Define a function to handle named routes in order to support
        // Flutter web url navigation and deep linking.
        onGenerateRoute: RouterService.router.generator,
        navigatorKey: NavigationService.navigatorKey,
        scaffoldMessengerKey: NotificationService.messengerKey,
        builder: (_, child) => SafeArea(child: _build(child, context)),
      ),
    );
  }

  Widget _build(Widget? child, BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return switch (authProvider.authStatus) {
      AuthStatus.checking => const SplashPage(),
      AuthStatus.authenticated => DashboardPage(child!),
      AuthStatus.notAuthenticated => AuthPage(child!),
    };
  }
}
