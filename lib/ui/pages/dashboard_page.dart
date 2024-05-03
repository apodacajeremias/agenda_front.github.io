import 'package:agenda_front/constants.dart';
import 'package:agenda_front/ui/widgets/search_field.dart';
import 'package:agenda_front/ui/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  final Widget child;
  const DashboardPage(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: [
        OverlayEntry(
            builder: (context) => Scaffold(
                  appBar: AppBar(
                      title: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        Padding(
                          padding: EdgeInsets.all(minimumSizing),
                          child: SearchField(),
                        ),
                      ])),
                  drawer: const Sidebar(),
                  body: child,
                ))
      ],
    );
  }
}
