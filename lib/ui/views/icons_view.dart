import 'package:agenda_front/constants.dart';
import 'package:flutter/material.dart';

import 'package:agenda_front/ui/cards/white_card.dart';

class IconsView extends StatelessWidget {
  const IconsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: const [
          Text('Icons'),
          SizedBox(height: defaultPadding),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            direction: Axis.horizontal,
            children: [
              WhiteCard(
                  // title: 'ac_unit',
                  width: 170,
                  child: Center(child: Icon(Icons.ac_unit))),
              WhiteCard(
                  // title: 'access_alarms',
                  width: 170,
                  child: Center(child: Icon(Icons.access_alarms))),
              WhiteCard(
                  // title: 'access_time_rounded',
                  width: 170,
                  child: Center(child: Icon(Icons.access_time_rounded))),
              WhiteCard(
                  // title: 'all_inbox',
                  width: 170,
                  child: Center(child: Icon(Icons.all_inbox))),
              WhiteCard(
                  // title: 'desktop_mac_sharp',
                  width: 170,
                  child: Center(child: Icon(Icons.desktop_mac_sharp))),
              WhiteCard(
                  // title: 'keyboard_tab_rounded',
                  width: 170,
                  child: Center(child: Icon(Icons.keyboard_tab_rounded))),
              WhiteCard(
                  // title: 'not_listed_location',
                  width: 170,
                  child: Center(child: Icon(Icons.not_listed_location))),
            ],
          )
        ],
      ),
    );
  }
}
