import 'package:agenda_front/constants.dart';
import 'package:agenda_front/extensions.dart';
import 'package:agenda_front/translate.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  final Widget child;

  const AuthPage(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scrollbar(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [child],
      ),
    ));
  }
}

class _MobileBody extends StatelessWidget {
  final Widget child;

  const _MobileBody({required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1000,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: 420,
            child: child,
          ),
        ],
      ),
    );
  }
}

class _DesktopBody extends StatelessWidget {
  final Widget child;

  const _DesktopBody({required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 600,
            height: double.infinity,
            child: Column(
              children: [
                const SizedBox(height: 50),
                Text(AppLocalizations.of(context)!.appTitle,
                    style: context.headlineLarge),
                const SizedBox(height: defaultSizing),
                Text(AppLocalizations.of(context)!.bienvenido,
                    style: context.titleLarge),
                const SizedBox(height: 50),
                Expanded(child: child),
              ],
            ),
          )
        ],
      ),
    );
  }
}
