import 'package:agenda_front/providers/auth_provider.dart';
import 'package:agenda_front/providers/sidemenu_provider.dart';
import 'package:agenda_front/routers/admin_handlers.dart';
import 'package:agenda_front/routers/dashboard_handlers.dart';
import 'package:agenda_front/routers/no_page_found_handlers.dart';
import 'package:agenda_front/routers/persona_handlers.dart';
import 'package:agenda_front/ui/views/login_view.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Flurorouter {
  static const TransitionType _transitionType = TransitionType.native;

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
  // static String personasRoute = '/personas';

  // Dashboard: Agenda
  static String agendasIndexRoute = '/agendas';
  static String agendasCreateRoute =
      '/agendas/create'; // Agenda no se puede editar, para eso estan las demas funciones
  static String agendasRescheduleRoute = '/agendas/reschedule/:id';
  static String agendasUnscheduleRoute = 'agendas/unschedule/:id';
  static String agendasPrioritizeRoute =
      '/agendas/prioritize/:id/:prioridad'; //Mostrar en menu principal
  static String agendasDepriorizeRoute = '/agendas/deprioritize/:id/:prioridad';
  static String agendaChangeSituationRoute =
      '/agendas/changeSituacion/:id/:situacion';

  // Dashboard: Beneficio
  static String beneficiosIndexRoute = '/beneficios';
  static String beneficiosCreateRoute = '/beneficios/create';
  static String beneficiosEditRoute = '/beneficios/:id';
  static String beneficiosPromoteRoute =
      '/beneficios/:id/:idPromocion'; //Seleccionar promocion para asociar al beneficio

  // Dashboard: Colaborador
  static String colaboradoresIndexRoute = '/colaboradores';
  static String colaboradoresCreateRoute = '/colaboradores/create';
  static String colaboradoresEditRoute = '/colaboradores/:id';

  // Dashboard: Empresa
  static String empresasConfigureRoute =
      '/empresas/configure'; //Para configurar la informacion de la empresa, no hay index

  // Dashboard: Grupo
  static String gruposIndexRoute = '/grupos';
  static String gruposCreateRoute = '/grupos/create';
  static String gruposEditRoute = '/grupos/:id';

  // Dashboard: Item
  static String itemsIndexRoute = '/items';
  static String itemsCreateRoute = '/items/create';
  static String itemsEditRoute = '/items/:id';

  // Dashboard: Persona
  static String personasIndexRoute = '/personas';
  static String personasCreateRoute = '/personas/create';
  static String personasEditRoute = '/personas/:id';

  // Dashboard: Promocion
  static String promocionesIndexRoute = '/promociones';
  static String promocionesCreateRoute = '/promociones/create';
  static String promocionesEditRoute = '/promociones/:id';
  static String promocionesAddBenefitsRoute =
      '/promociones/addBenefits/:id'; //Mostrar en menu principal

  // Dashboard: Transaccion
  static String transaccionesIndexRoute = '/transacciones';
  static String transaccionesCreateRoute = '/transacciones/create';
  static String transaccionesEditRoute = '/transacciones/:id';
  static String transaccionesPrintRoute = '/transacciones/print/:id';
  static String transaccionesAddDetailsRoute =
      '/transacciones/addDetails/:id'; //Mostrar en menu

  // Dashboard: Transaccion Detalle
  static String transaccionesDetallesReportRoute =
      '/transaccionesDetalles/report';
  static String transaccionesDetallesPrintRoute =
      '/transaccionesDetalles/print'; // Reporte

  // Dashboard: User
  static String usersIndexRoute = '/users';
  static String usersCreateRoute = '/users/create';
  static String usersEditRoute = '/users/:id';
  static String usersResetPasswordRoute = '/users/resetPassword/:id';
  static String usersResendVerificationRoute = '/users/resendVerification/:id';
  static String usersUpdatePasswordRoute = '/users/updatePassword/:id';

  static void configureRoutes() {
    // Auth Routes
    router.define(rootRoute,
        handler: AdminHandlers.login, transitionType: _transitionType);
    router.define(loginRoute,
        handler: AdminHandlers.login, transitionType: _transitionType);
    router.define(registerRoute,
        handler: AdminHandlers.register, transitionType: _transitionType);

    // Dashboard
    router.define(dashboardRoute,
        handler: DashboardHandlers.dashboard, transitionType: _transitionType);
    router.define(iconsRoute,
        handler: DashboardHandlers.icons, transitionType: _transitionType);
    router.define(blankRoute,
        handler: DashboardHandlers.blank, transitionType: _transitionType);
    router.define(categoriesRoute,
        handler: DashboardHandlers.categories, transitionType: _transitionType);

    // Dashboard: Persona
    router.define(personasIndexRoute,
        handler: PersonaHandlers.index, transitionType: _transitionType);
    router.define(personasCreateRoute,
        handler: PersonaHandlers.crear, transitionType: _transitionType);
    router.define(personasEditRoute,
        handler: PersonaHandlers.editar, transitionType: _transitionType);

    // Users
    router.define(usersIndexRoute,
        handler: DashboardHandlers.users, transitionType: _transitionType);

    // 404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }

  static Widget build(BuildContext context, String flurorouter, Widget child) {
    final authProvider = Provider.of<AuthProvider>(context);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(flurorouter);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return child;
    } else {
      return const LoginView();
    }
  }
}
