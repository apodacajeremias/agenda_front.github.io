import 'package:agenda_front/constants.dart';
import 'package:flutter/material.dart';

import 'package:agenda_front/ui/layouts/auth/widgets/custom_background.dart';
import 'package:agenda_front/ui/layouts/auth/widgets/my_title.dart';

class NoProfileLayout extends StatelessWidget {
  final Widget child;

  const NoProfileLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: Scrollbar(
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
    return SizedBox(
      height: 1000,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: defaultPadding),
          const MyTitle(title: 'Complete el formulario', asset: 'logo.png'),
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
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Row(
        children: [
          // Background
          const Expanded(child: CustomBackground()),

          // View Container
          SizedBox(
            width: 600,
            height: double.infinity,
            child: Column(
              children: [
                const SizedBox(height: 50),
                const MyTitle(
                    title: 'Complete el formulario', asset: 'logo.png'),
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
