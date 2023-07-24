import 'package:agenda_front/providers/auth_provider.dart';
import 'package:agenda_front/providers/sidemenu_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/ui/shared/widgets/logo.dart';
import 'package:agenda_front/ui/shared/widgets/menu_item_custom.dart';
import 'package:agenda_front/ui/shared/widgets/text_separator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  void navigateTo(String routeName) {
    NavigationService.replaceTo(routeName);
    SideMenuProvider.closeMenu();
  }

  @override
  Widget build(BuildContext context) {
    final sideMenuProvider = Provider.of<SideMenuProvider>(context);

    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const Logo(),
          const SizedBox(height: 50),
          const TextSeparator(text: 'Principal'),
          MenuItemCustom(
            text: 'Inicio',
            icon: Icons.cottage,
            onPressed: () => navigateTo(Flurorouter.dashboardRoute),
            isActive:
                sideMenuProvider.currentPage == Flurorouter.dashboardRoute,
          ),
          MenuItemCustom(
            text: 'Agendas',
            icon: Icons.schedule,
            onPressed: () => navigateTo(Flurorouter.agendasIndexRoute),
            isActive:
                sideMenuProvider.currentPage == Flurorouter.agendasIndexRoute,
          ),
          MenuItemCustom(
            text: 'Beneficios',
            icon: Icons.celebration,
            onPressed: () => navigateTo(Flurorouter.beneficiosIndexRoute),
            isActive: sideMenuProvider.currentPage ==
                Flurorouter.beneficiosIndexRoute,
          ),
          MenuItemCustom(
              text: 'Configuraciones',
              icon: Icons.settings,
              onPressed: () => navigateTo(Flurorouter.empresasConfigureRoute),
              isActive: sideMenuProvider.currentPage ==
                  Flurorouter.empresasConfigureRoute),
          MenuItemCustom(
            text: 'Colaboradores',
            icon: Icons.account_box,
            onPressed: () => navigateTo(Flurorouter.colaboradoresIndexRoute),
            isActive: sideMenuProvider.currentPage ==
                Flurorouter.colaboradoresIndexRoute,
          ),
          MenuItemCustom(
            text: 'Grupos',
            icon: Icons.groups,
            onPressed: () => navigateTo(Flurorouter.gruposIndexRoute),
            isActive:
                sideMenuProvider.currentPage == Flurorouter.gruposIndexRoute,
          ),
          MenuItemCustom(
            text: 'Items',
            icon: Icons.category,
            onPressed: () => navigateTo(Flurorouter.itemsIndexRoute),
            isActive:
                sideMenuProvider.currentPage == Flurorouter.itemsIndexRoute,
          ),
          MenuItemCustom(
            text: 'Personas',
            icon: Icons.people,
            onPressed: () => navigateTo(Flurorouter.personasIndexRoute),
            isActive:
                sideMenuProvider.currentPage == Flurorouter.personasIndexRoute,
          ),
          MenuItemCustom(
            text: 'Promociones',
            icon: Icons.discount,
            onPressed: () => navigateTo(Flurorouter.promocionesIndexRoute),
            isActive: sideMenuProvider.currentPage ==
                Flurorouter.promocionesIndexRoute,
          ),
          MenuItemCustom(
              text: 'Transacciones',
              icon: Icons.receipt_long,
              onPressed: () => navigateTo(Flurorouter.transaccionesIndexRoute),
              isActive: sideMenuProvider.currentPage ==
                  Flurorouter.transaccionesEditRoute),
          const SizedBox(height: 50),
          const TextSeparator(text: 'Salir'),
          MenuItemCustom(
              text: 'Cerrar sesión',
              icon: Icons.exit_to_app_outlined,
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logout();
              }),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      gradient: LinearGradient(colors: [
        Color(0xff092044),
        Color(0xff092042),
      ]),
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)]);
}
