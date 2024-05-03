import 'package:agenda_front/services.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium;
    return Drawer(
        child: ListView(children: [
      const DrawerHeader(child: SizedBox(height: 32)),
      ListTile(
          title: Text('Inicio', style: style),
          leading: const Icon(Icons.home_outlined),
          onTap: () {
            NavigationService.replaceTo(RouterService.rootRoute);
          }),
      const Divider(),
    ]));
  }
}
