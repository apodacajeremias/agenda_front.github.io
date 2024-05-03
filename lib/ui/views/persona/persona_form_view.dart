import 'package:agenda_front/constants.dart';
import 'package:agenda_front/extensions.dart';
import 'package:agenda_front/providers.dart';
import 'package:agenda_front/src/models/entities/persona.dart';
import 'package:agenda_front/ui/views/agenda/agenda_form_view.dart';
import 'package:agenda_front/ui/views/agenda/agenda_index_view.dart';
import 'package:agenda_front/ui/views/transaccion/transaccion_index_view.dart';
import 'package:agenda_front/ui/widgets/avatar.dart';
import 'package:agenda_front/ui/widgets/elevated_button.dart';
import 'package:agenda_front/ui/widgets/form_header.dart';
import 'package:agenda_front/ui/widgets/no_info_card.dart';
import 'package:agenda_front/ui/widgets/text_profile_detail.dart';
import 'package:agenda_front/ui/widgets/text_separator.dart';
import 'package:agenda_front/ui/widgets/waiting_card.dart';
import 'package:agenda_front/ui/widgets/white_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonaView extends StatefulWidget {
  final Persona? persona;

  const PersonaView({super.key, this.persona});

  @override
  State<PersonaView> createState() => _PersonaViewState();
}

class _PersonaViewState extends State<PersonaView> {
  bool isProfile = false;

  @override
  Widget build(BuildContext context) {
    isProfile = widget.persona != null;
    return isProfile ? _PersonaProfile(widget.persona!) : _form();
  }

  Widget _form() {
    return Container(
      child: const Center(
        child: Text('buuuuuuuuuuuuuug'),
      ),
    );
  }
}

class _PersonaProfile extends StatelessWidget {
  final Persona persona;
  const _PersonaProfile(this.persona);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const FormHeader(title: 'Perfil'),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: _PersonaProfileDetails(persona)),
          Expanded(flex: 4, child: _PersonaProfileDashboard(persona))
        ],
      ),
    ]);
  }
}

class _PersonaProfileDetails extends StatelessWidget {
  final Persona persona;
  const _PersonaProfileDetails(this.persona);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(minimumSizing),
      child: Column(
        children: [
          WhiteCard(
              footer: EButton.edit(onPressed: () {
                print('EDIT PRESSED');
              }),
              child: Column(
                children: [
                  Center(
                      child: Avatar(
                    persona.fotoPerfil ?? '',
                    size: 200,
                  )),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          persona.nombre ??
                              'Eiusmod commodo duis ea ut Lorem sunt duis commodo consequat qui nisi reprehenderit sunt proident.',
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                            persona.colaborador != null
                                ? 'Colaborador'
                                : 'Cliente',
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleSmall),
                      ],
                    ),
                  ),
                  const Divider(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Transacciones',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        Text('0',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: Colors.blue)),
                      ]),
                  const Divider(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Pagos',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        Text('0',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: Colors.blue)),
                      ]),
                  const Divider(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Agendamientos',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        Text('0',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: Colors.blue)),
                      ]),
                ],
              )),
          WhiteCard(
              child: Column(
            children: [
              TextProfileDetail(
                  icon: Icons.badge_outlined,
                  title: 'Documento',
                  text: persona.documentoIdentidad),
              TextProfileDetail(
                  icon: Icons.cake_outlined,
                  text: persona.fechaNacimiento.formatDate()),
              TextProfileDetail(
                  icon: Icons.info_outline,
                  title: 'Edad',
                  text: persona.edad.toString()),
              TextProfileDetail(
                  icon: persona.genero!.icon,
                  text: persona.genero!.toString(),
                  hasDivider: false),
              if (persona.colaborador != null) ...[
                const SizedBox(height: minimumSizing),
                const TextSeparator(
                    text: 'Información profesional', color: Colors.black),
                const SizedBox(height: minimumSizing),
                TextProfileDetail(
                    icon: Icons.info_outline,
                    title: 'Registro de Contribuyente',
                    text: persona.colaborador?.registroContribuyente),
                TextProfileDetail(
                    icon: Icons.info_outline,
                    title: 'Registro de Profesional',
                    text: persona.colaborador?.registroProfesional),
                TextProfileDetail(
                    icon: Icons.info_outline,
                    title: 'Profesión',
                    text: persona.colaborador?.profesion,
                    hasDivider: false),
              ],
            ],
          ))
        ],
      ),
    );
  }
}

class _PersonaProfileDashboard extends StatelessWidget {
  final Persona persona;
  const _PersonaProfileDashboard(this.persona);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PersonaProfileDashboardAgendamientos(persona),
        _PersonaProfileDashboardTransacciones(persona)
      ],
    );
  }
}

class _PersonaProfileDashboardTransacciones extends StatefulWidget {
  final Persona persona;
  const _PersonaProfileDashboardTransacciones(this.persona);

  @override
  State<_PersonaProfileDashboardTransacciones> createState() =>
      __PersonaProfileDashboardTransaccionesState();
}

class __PersonaProfileDashboardTransaccionesState
    extends State<_PersonaProfileDashboardTransacciones> {
  @override
  Widget build(BuildContext context) {
    Provider.of<TransaccionProvider>(context);
    return FutureBuilder(
      future: Provider.of<PersonaProvider>(context, listen: false)
          .transacciones(widget.persona.id!),
      builder: (context, snapshot) {
        String title = 'Transacciones';
        if (snapshot.connectionState == ConnectionState.waiting) {
          return WaitingCard(title: title);
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.isNotEmpty) {
            return TransaccionIndexView(data: snapshot.data);
          }
        }
        return NoInfoCard(
            title: title,
            action: EButton.create(onPressed: () {
              final dialog = AlertDialog(
                  content: AgendaFormDialog(
                persona: widget.persona,
              ));
              showDialog(context: context, builder: (_) => dialog);
            }));
      },
    );
  }
}

class _PersonaProfileDashboardAgendamientos extends StatefulWidget {
  final Persona persona;

  const _PersonaProfileDashboardAgendamientos(this.persona);

  @override
  State<_PersonaProfileDashboardAgendamientos> createState() =>
      __PersonaProfileDashboardAgendamientosState();
}

class __PersonaProfileDashboardAgendamientosState
    extends State<_PersonaProfileDashboardAgendamientos> {
  @override
  void initState() {
    Provider.of<ColaboradorProvider>(context, listen: false).buscarTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AgendaProvider>(context);
    return FutureBuilder(
      future: Provider.of<PersonaProvider>(context, listen: false)
          .agendas(widget.persona.id!),
      builder: (context, snapshot) {
        String title = 'Agendamientos';
        if (snapshot.connectionState == ConnectionState.waiting) {
          return WaitingCard(title: title);
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.isNotEmpty) {
            return AgendaIndexView(data: snapshot.data);
          }
        }
        return NoInfoCard(
            title: title,
            action: EButton.create(onPressed: () {
              final dialog = AlertDialog(
                  content: AgendaFormDialog(
                persona: widget.persona,
              ));
              showDialog(context: context, builder: (_) => dialog);
            }));
      },
    );
  }
}
