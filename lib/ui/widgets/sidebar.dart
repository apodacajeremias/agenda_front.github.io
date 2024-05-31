import 'package:agenda_front/constants.dart';
import 'package:agenda_front/extensions.dart';
import 'package:agenda_front/providers.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/translate.dart';
import 'package:agenda_front/ui/widgets/outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium;
    return Drawer(
        child: ListView(children: [
      const DrawerHeader(child: _SidebarDrawer()),
      ListTile(
          title: Text('Inicio', style: style),
          leading: const Icon(Icons.home_outlined),
          onTap: () {
            NavigationService.replaceTo(RouterService.rootRoute);
          }),
      const Divider(),
      ListTile(
          title: Text('Agendas', style: style),
          leading: const Icon(Icons.calendar_month_outlined),
          onTap: () async {
            // print('click');
            NavigationService.replaceTo(RouterService.agendasIndexRoute);
          }),
      const Divider(),
      ListTile(
          title: Text('Beneficios', style: style),
          leading: const Icon(Icons.redeem_outlined),
          onTap: () async {
            // print('click');
            NavigationService.replaceTo(RouterService.beneficiosIndexRoute);
          }),
      const Divider(),
      ListTile(
          title: Text('Credenciales', style: style),
          leading: const Icon(Icons.admin_panel_settings_outlined),
          onTap: () async {
            print('click');
          }),
      const Divider(),
      ListTile(
          title: Text('Colaboradores', style: style),
          leading: const Icon(Icons.manage_accounts_outlined),
          onTap: () async {
            // print('click');
            NavigationService.replaceTo(RouterService.colaboradoresIndexRoute);
          }),
      const Divider(),
      ListTile(
          title: Text('Empresa', style: style),
          leading: const Icon(Icons.settings),
          onTap: () async {
            // print('click');
            NavigationService.replaceTo(RouterService.empresasConfigureRoute);
          }),
      const Divider(),
      ListTile(
          title: Text('Grupos', style: style),
          leading: const Icon(Icons.groups_outlined),
          onTap: () async {
            print('click');
            NavigationService.replaceTo(RouterService.gruposIndexRoute);
          }),
      const Divider(),
      ListTile(
          title: Text('Items', style: style),
          leading: const Icon(Icons.sell_outlined),
          onTap: () async {
            // print('click');
            NavigationService.replaceTo(RouterService.itemsIndexRoute);
          }),
      const Divider(),
      ListTile(
          title: Text('Personas', style: style),
          leading: const Icon(Icons.face_outlined),
          onTap: () async {
            // print('click');
            NavigationService.replaceTo(RouterService.personasIndexRoute);
          }),
      const Divider(),
      ListTile(
          title: Text('Promociones', style: style),
          leading: const Icon(Icons.redeem_outlined),
          onTap: () async {
            // print('click');
            NavigationService.replaceTo(RouterService.promocionesIndexRoute);
          }),
      const Divider(),
      ListTile(
          title: Text('Transacciones', style: style),
          leading: const Icon(Icons.request_page_outlined),
          onTap: () async {
            // print('click');
            NavigationService.replaceTo(RouterService.transaccionesIndexRoute);
          }),
      const Divider(),
      ListTile(
          title: Text('Usuarios', style: style),
          leading: const Icon(Icons.supervised_user_circle_sharp),
          onTap: () async {
            // print('click');
            NavigationService.replaceTo(RouterService.usersIndexRoute);
          })
    ]));
  }
}

class _SidebarDrawer extends StatelessWidget {
  const _SidebarDrawer();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);
    final style = Theme.of(context).textTheme.titleLarge;
    final style2 = Theme.of(context).textTheme.titleMedium;
    return Container(
        margin: const EdgeInsets.only(top: minimumSizing),
        padding: const EdgeInsets.symmetric(horizontal: minimumSizing),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(AppLocalizations.of(context)!.appTitle, style: style),
            const SizedBox(height: defaultSizing),
            Text(provider.empresa!.nombre, style: style),
            const SizedBox(height: defaultSizing),
            Text(
                '${AppLocalizations.of(context)!.bienvenido} ${provider.persona!.nombre.firstWord()}',
                style: style2),
            const SizedBox(height: defaultSizing),
            OButton.salir(provider)
          ],
        ));
  }
}
