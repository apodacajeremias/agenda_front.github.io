import 'package:flutter/material.dart';

import 'package:agenda_front/ui/layouts/auth/widgets/custom_background.dart';
import 'package:agenda_front/ui/layouts/auth/widgets/custom_title.dart';

class AuthLayout extends StatelessWidget {
  final Widget child;

  const AuthLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: Scrollbar(
      // isAlwaysShown: true,
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          (size.width > 1000)
              ? _DesktopBody(child: child)
              : _MobileBody(child: child),

          // LinksBar
          // const LinksBar()
        ],
      ),
    ));
  }
}

class _MobileBody extends StatelessWidget {
  final Widget child;

  const _MobileBody({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      color: Colors.blueGrey.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const CustomTitle(),
          SizedBox(
            width: double.infinity,
            height: 420,
            child: child,
          ),
          const SizedBox(
            width: double.infinity,
            height: 400,
            child: CustomBackground(),
          )
        ],
      ),
    );
  }
}

class _DesktopBody extends StatelessWidget {
  final Widget child;

  const _DesktopBody({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      color: Colors.blueGrey.shade100,
      child: Row(
        children: [
          // Background
          const Expanded(child: CustomBackground()),

          // View Container
          Container(
            width: 600,
            height: double.infinity,
            color: Colors.blueGrey.shade100,
            child: Column(
              children: [
                const SizedBox(height: 20),
                const CustomTitle(),
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
