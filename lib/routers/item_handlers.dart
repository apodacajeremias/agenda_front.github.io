import 'package:agenda_front/models/entities/item.dart';
import 'package:agenda_front/providers/auth_provider.dart';
import 'package:agenda_front/providers/item_provider.dart';
import 'package:agenda_front/providers/sidemenu_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/ui/views/forms/item_form_view.dart';
import 'package:agenda_front/ui/views/indexs/item_index_view.dart';
import 'package:agenda_front/ui/views/login_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class ItemHandlers {
  static Handler index = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.itemsIndexRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const ItemIndexView();
    } else {
      return const LoginView();
    }
  });

  static Handler create = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.agendasIndexRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const ItemFormView();
    } else {
      return const LoginView();
    }
  });

  static Handler edit = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.personasIndexRoute);

    final item = Provider.of<ItemProvider>(context, listen: false)
        .buscar(params['id']!.first) as Item;

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return ItemFormView(item: item);
    } else {
      return const LoginView();
    }
  });
}
