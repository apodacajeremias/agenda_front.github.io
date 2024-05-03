import 'package:agenda_front/ui/views/auth/page_not_found_view.dart';
import 'package:fluro/fluro.dart';

class PageNotFoundHandler {
  static Handler noPageFound = Handler(handlerFunc: (context, parameters) {
    return const PageNotFoundView();
  });
}
