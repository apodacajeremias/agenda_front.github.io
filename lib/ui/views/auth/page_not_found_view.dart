import 'package:agenda_front/extensions.dart';
import 'package:agenda_front/ui/widgets/link_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PageNotFoundView extends StatelessWidget {
  const PageNotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(shrinkWrap: true, children: [
        Text(
          AppLocalizations.of(context)!.paginaNoEncontrada,
          style: context.headlineLarge?.apply(color: Colors.redAccent),
        ),
        LinkButton.back(onPressed: () => Navigator.of(context).pop())
      ]),
    );
  }
}
