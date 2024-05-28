import 'package:agenda_front/src/handlers/agenda_handler.dart';
import 'package:agenda_front/src/handlers/auth_handler.dart';
import 'package:agenda_front/src/handlers/beneficio_handler.dart';
import 'package:agenda_front/src/handlers/colaborador_handler.dart';
import 'package:agenda_front/src/handlers/grupo_handler.dart';
import 'package:agenda_front/src/handlers/item_handler.dart';
import 'package:agenda_front/src/handlers/page_not_found_handler.dart';
import 'package:agenda_front/src/handlers/promocion_handler.dart';
import 'package:agenda_front/src/handlers/transaccion_handler.dart';
import 'package:fluro/fluro.dart';

import '../handlers/persona_handler.dart';

class RouterService {
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

  static void configure() {
    // Auth Routes
    router.define(rootRoute,
        handler: AuthHandler.login, transitionType: _transitionType);
    router.define(loginRoute,
        handler: AuthHandler.login, transitionType: _transitionType);
    router.define(registerRoute,
        handler: AuthHandler.register, transitionType: _transitionType);

    //TODO: ASIGNAR TODOS LOS Handler
    // Agenda
    router.define(agendasIndexRoute,
        handler: AgendaHandler.index, transitionType: _transitionType);
    router.define(agendasCreateRoute,
        handler: AgendaHandler.create, transitionType: _transitionType);
    router.define(agendasRescheduleRoute,
        handler: AgendaHandler.reschedule, transitionType: _transitionType);
    router.define(agendasUnscheduleRoute,
        handler: AgendaHandler.unschedule, transitionType: _transitionType);
    router.define(agendasPrioritizeRoute,
        handler: AgendaHandler.prioritize, transitionType: _transitionType);
    router.define(agendasDepriorizeRoute,
        handler: AgendaHandler.deprioritize, transitionType: _transitionType);
    router.define(agendaChangeSituationRoute,
        handler: AgendaHandler.changeSituation,
        transitionType: _transitionType);

    // Beneficio
    router.define(beneficiosIndexRoute,
        handler: BeneficioHandler.index, transitionType: _transitionType);
    router.define(beneficiosCreateRoute,
        handler: BeneficioHandler.create, transitionType: _transitionType);
    router.define(beneficiosEditRoute,
        handler: BeneficioHandler.edit, transitionType: _transitionType);

    // Colaborador
    router.define(colaboradoresIndexRoute,
        handler: ColaboradorHandler.index, transitionType: _transitionType);
    // router.define(colaboradoresCreateRoute,
    //     handler: ColaboradorHandler.create, transitionType: _transitionType);
    // router.define(colaboradoresEditRoute,
    //     handler: ColaboradorHandler.edit, transitionType: _transitionType);

// TODO: Empresa

    // Grupo
    router.define(gruposIndexRoute,
        handler: GrupoHandler.index, transitionType: _transitionType);
    router.define(gruposCreateRoute,
        handler: GrupoHandler.create, transitionType: _transitionType);
    router.define(gruposEditRoute,
        handler: GrupoHandler.edit, transitionType: _transitionType);

    // Item
    router.define(itemsIndexRoute,
        handler: ItemHandler.index, transitionType: _transitionType);
    router.define(itemsCreateRoute,
        handler: ItemHandler.create, transitionType: _transitionType);
    router.define(itemsEditRoute,
        handler: ItemHandler.edit, transitionType: _transitionType);

    // Persona
    router.define(personasIndexRoute,
        handler: PersonaHandler.index, transitionType: _transitionType);
    router.define(personasCreateRoute,
        handler: PersonaHandler.create, transitionType: _transitionType);
    router.define(personasEditRoute,
        handler: PersonaHandler.edit, transitionType: _transitionType);

    // Promocion
    router.define(promocionesIndexRoute,
        handler: PromocionHandler.index, transitionType: _transitionType);
    router.define(promocionesCreateRoute,
        handler: PromocionHandler.create, transitionType: _transitionType);
    router.define(promocionesEditRoute,
        handler: PromocionHandler.edit, transitionType: _transitionType);

    // TODO: Token

    // Transaccion
    // TODO: faltan enlaces
    router.define(transaccionesIndexRoute,
        handler: TransaccionHandler.index, transitionType: _transitionType);
    router.define(transaccionesCreateRoute,
        handler: TransaccionHandler.create, transitionType: _transitionType);
    router.define(transaccionesEditRoute,
        handler: TransaccionHandler.edit, transitionType: _transitionType);

    // Users
    // router.define(usersIndexRoute,
    //     handler: DashboardHandler.users, transitionType: _transitionType);

    // 404
    router.notFoundHandler = PageNotFoundHandler.noPageFound;
  }
}
