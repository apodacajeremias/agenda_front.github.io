import 'package:agenda_front/constants.dart';
import 'package:agenda_front/response.dart';
import 'package:agenda_front/ui/views/forms/persona_form_view.dart';
import 'package:flutter/material.dart';

class NoProfileLayout extends StatelessWidget {
  const NoProfileLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scrollbar(
            child: (Responsive.isDesktop(context))
                ? const _DesktopBody()
                : const _MobileBody()));
  }
}

class _MobileBody extends StatelessWidget {
  const _MobileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(children: [
        Text(
          'Completa los siguientes datos',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const PersonaView()
      ]),
    );
  }
}

class _DesktopBody extends StatelessWidget {
  const _DesktopBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container(color: Colors.transparent)),
        Expanded(
            child: Column(
          children: [
            Text(
              'Completa los siguientes datos',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const PersonaView()
          ],
        )),
        Expanded(child: Container(color: Colors.transparent)),
      ],
    );
  }
}
