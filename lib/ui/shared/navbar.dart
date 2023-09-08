import 'package:agenda_front/constants.dart';
import 'package:agenda_front/providers/auth_provider.dart';
import 'package:agenda_front/providers/sidemenu_provider.dart';
import 'package:agenda_front/ui/shared/widgets/avatar.dart';
import 'package:agenda_front/ui/shared/widgets/notifications_indicator.dart';
import 'package:agenda_front/ui/shared/widgets/search_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final personaEnSesion =
        Provider.of<AuthProvider>(context, listen: false).persona;

    return Container(
      width: double.infinity,
      height: 50,
      decoration: buildBoxDecoration(context),
      child: Row(
        children: [
          if (size.width <= 700)
            IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => SideMenuProvider.openMenu()),

          const SizedBox(width: 5),

          // Search input
          if (size.width > 390)
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 250),
              child: const SearchText(),
            ),

          const Spacer(),

          const NotificationsIndicator(),
          const SizedBox(width: defaultPadding),
          Avatar(personaEnSesion?.fotoPerfil ?? ''),
          const SizedBox(width: 10)
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration(BuildContext context) =>
      BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.5),
            blurRadius: 5)
      ]);
}
