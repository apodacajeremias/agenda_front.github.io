import 'package:agenda_front/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PageNotFoundView extends StatelessWidget {
  const PageNotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppLocalizations.of(context)!.paginaNoEncontrada,
        style: context.headlineLarge?.apply(color: Colors.redAccent),
      ),
    );
  }
}
