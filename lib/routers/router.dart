import 'package:agenda_front/routers/admin_handlers.dart';
import 'package:agenda_front/routers/agenda_handlers.dart';
import 'package:agenda_front/routers/beneficio_handlers.dart';
import 'package:agenda_front/routers/colaborador_handlers.dart';
import 'package:agenda_front/routers/dashboard_handlers.dart';
import 'package:agenda_front/routers/grupo_handlers.dart';
import 'package:agenda_front/routers/item_handlers.dart';
import 'package:agenda_front/routers/no_page_found_handlers.dart';
import 'package:agenda_front/routers/persona_handlers.dart';
import 'package:agenda_front/routers/promocion_handlers.dart';
import 'package:agenda_front/routers/transaccion_handlers.dart';
import 'package:fluro/fluro.dart';

class Flurorouter {
  static const TransitionType _transitionType = TransitionType.native;

  static final FluroRouter router = FluroRouter();

  static String rootRoute = '/';

  // Auth Router
  static String loginRoute = '/auth/login';
  static String registerRoute = '/auth/register';
  // Configure
  static String configureRoute = '/auth/configure';

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
    router.define(configureRoute,
        handler: AdminHandlers.configure, transitionType: _transitionType);

    // Dashboard
    router.define(dashboardRoute,
        handler: DashboardHandlers.dashboard, transitionType: _transitionType);
    router.define(iconsRoute,
        handler: DashboardHandlers.icons, transitionType: _transitionType);
    router.define(blankRoute,
        handler: DashboardHandlers.blank, transitionType: _transitionType);
    router.define(categoriesRoute,
        handler: DashboardHandlers.categories, transitionType: _transitionType);

    //TODO: ASIGNAR TODOS LOS HANDLERS
    // Agenda
    router.define(agendasIndexRoute,
        handler: AgendaHandlers.index, transitionType: _transitionType);
    router.define(agendasCreateRoute,
        handler: AgendaHandlers.create, transitionType: _transitionType);
    router.define(agendasRescheduleRoute,
        handler: AgendaHandlers.reschedule, transitionType: _transitionType);
    router.define(agendasUnscheduleRoute,
        handler: AgendaHandlers.unschedule, transitionType: _transitionType);
    router.define(agendasPrioritizeRoute,
        handler: AgendaHandlers.prioritize, transitionType: _transitionType);
    router.define(agendasDepriorizeRoute,
        handler: AgendaHandlers.deprioritize, transitionType: _transitionType);
    router.define(agendaChangeSituationRoute,
        handler: AgendaHandlers.changeSituation,
        transitionType: _transitionType);

    // Beneficio
    router.define(beneficiosIndexRoute,
        handler: BeneficioHandlers.index, transitionType: _transitionType);
    router.define(beneficiosCreateRoute,
        handler: BeneficioHandlers.create, transitionType: _transitionType);
    router.define(beneficiosEditRoute,
        handler: BeneficioHandlers.edit, transitionType: _transitionType);

    // Colaborador
    router.define(colaboradoresIndexRoute,
        handler: ColaboradorHandlers.index, transitionType: _transitionType);
    router.define(colaboradoresCreateRoute,
        handler: ColaboradorHandlers.create, transitionType: _transitionType);
    router.define(colaboradoresEditRoute,
        handler: ColaboradorHandlers.edit, transitionType: _transitionType);

// TODO: Empresa

    // Grupo
    router.define(gruposIndexRoute,
        handler: GrupoHandlers.index, transitionType: _transitionType);
    router.define(gruposCreateRoute,
        handler: GrupoHandlers.create, transitionType: _transitionType);
    router.define(gruposEditRoute,
        handler: GrupoHandlers.edit, transitionType: _transitionType);

    // Item
    router.define(itemsIndexRoute,
        handler: ItemHandlers.index, transitionType: _transitionType);
    router.define(itemsCreateRoute,
        handler: ItemHandlers.create, transitionType: _transitionType);
    router.define(itemsEditRoute,
        handler: ItemHandlers.edit, transitionType: _transitionType);

    // Persona
    router.define(personasIndexRoute,
        handler: PersonaHandlers.index, transitionType: _transitionType);
    router.define(personasCreateRoute,
        handler: PersonaHandlers.create, transitionType: _transitionType);
    router.define(personasEditRoute,
        handler: PersonaHandlers.edit, transitionType: _transitionType);

    // Promocion
    router.define(promocionesIndexRoute,
        handler: PromocionHandlers.index, transitionType: _transitionType);
    router.define(promocionesCreateRoute,
        handler: PromocionHandlers.create, transitionType: _transitionType);
    router.define(promocionesEditRoute,
        handler: PromocionHandlers.edit, transitionType: _transitionType);

    // TODO: Token

    // Transaccion
    // TODO: faltan enlaces
    router.define(transaccionesIndexRoute,
        handler: TransaccionHandlers.index, transitionType: _transitionType);
    router.define(transaccionesCreateRoute,
        handler: TransaccionHandlers.create, transitionType: _transitionType);
    router.define(transaccionesEditRoute,
        handler: TransaccionHandlers.edit, transitionType: _transitionType);

    // Users
    router.define(usersIndexRoute,
        handler: DashboardHandlers.users, transitionType: _transitionType);

    // 404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
}
