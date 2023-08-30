import 'package:agenda_front/constants.dart';
import 'package:agenda_front/providers/auth_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return GestureDetector(
      onTap: () => NavigationService.replaceTo(Flurorouter.dashboardRoute),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.only(top: defaultPadding * 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.account_circle, color: Colors.white),
              const SizedBox(width: defaultPadding),
              Text(
                authProvider.usuario?.persona?.nombre!.split(' ').first ??
                    'N/A',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.apply(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
