import 'package:agenda_front/routers/admin_handlers.dart';
import 'package:agenda_front/routers/dashboard_handlers.dart';
import 'package:agenda_front/routers/no_page_found_handlers.dart';
import 'package:agenda_front/routers/persona_handlers.dart';
import 'package:fluro/fluro.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static String rootRoute = '/';

  // Auth Router
  static String loginRoute = '/auth/login';
  static String registerRoute = '/auth/register';

  // Dashboard
  static String dashboardRoute = '/dashboard';
  static String iconsRoute = '/dashboard/icons';
  static String blankRoute = '/dashboard/blank';
  static String categoriesRoute = '/dashboard/categories';
  // static String personasRoute = '/dashboard/personas';

  // Dashboard: Persona
  static String personasIndexRoute = '/dashboard/personas';
  static String personasCreateRoute = '/dashboard/personas/create';
  static String personasEditRoute = '/dashboard/personas/:id';

  static String usersRoute = '/dashboard/users';

  static void configureRoutes() {
    // Auth Routes
    router.define(rootRoute,
        handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(loginRoute,
        handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(registerRoute,
        handler: AdminHandlers.register, transitionType: TransitionType.none);

    // Dashboard
    router.define(dashboardRoute,
        handler: DashboardHandlers.dashboard,
        transitionType: TransitionType.fadeIn);
    router.define(iconsRoute,
        handler: DashboardHandlers.icons,
        transitionType: TransitionType.fadeIn);
    router.define(blankRoute,
        handler: DashboardHandlers.blank,
        transitionType: TransitionType.fadeIn);
    router.define(categoriesRoute,
        handler: DashboardHandlers.categories,
        transitionType: TransitionType.fadeIn);

    // Dashboard: Persona
    router.define(personasIndexRoute,
        handler: PersonaHandlers.index, transitionType: TransitionType.fadeIn);
    router.define(personasCreateRoute,
        handler: PersonaHandlers.create, transitionType: TransitionType.fadeIn);
    router.define(personasEditRoute,
        handler: PersonaHandlers.edit, transitionType: TransitionType.fadeIn);

    // Users
    router.define(usersRoute,
        handler: DashboardHandlers.users,
        transitionType: TransitionType.fadeIn);

    // 404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
}
