import 'package:agenda_front/providers/sidemenu_provider.dart';
import 'package:agenda_front/ui/views/no_page_found.view.dart';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';


class NoPageFoundHandlers {

  static Handler noPageFound = Handler(
    handlerFunc: ( context, params ) {

      Provider.of<SideMenuProvider>(context!, listen: false).setCurrentPageUrl('/404');

      return const NoPageFoundView();
    }
  );


}

