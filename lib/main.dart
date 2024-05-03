import 'package:agenda_front/providers.dart';
import 'package:agenda_front/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/app.dart';

//TODO: Llenar en archivo .arb con las etiquetas y sus traducciones
void main() async {
  // Configurar cache
  await LocalStorage.configurePrefs();
  // Configurar conexion con servidor
  ServerConection.configureDio();
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
        ChangeNotifierProvider(lazy: true, create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    );
  }
}
