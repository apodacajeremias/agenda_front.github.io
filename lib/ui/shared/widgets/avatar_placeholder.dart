import 'package:agenda_front/constants.dart';
import 'package:agenda_front/providers/auth_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/ui/shared/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvatarPlaceholder extends StatelessWidget {
  const AvatarPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final personaEnSesion =
        Provider.of<AuthProvider>(context, listen: false).persona;
    return GestureDetector(
      onTap: () => NavigationService.replaceTo(Flurorouter.dashboardRoute),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.all(defaultPadding * 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Avatar(personaEnSesion?.fotoPerfil ?? '', size: 40),
              const SizedBox(width: defaultPadding),
              Text(
                personaEnSesion?.nombre!.split(' ').first ?? '',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.apply(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
