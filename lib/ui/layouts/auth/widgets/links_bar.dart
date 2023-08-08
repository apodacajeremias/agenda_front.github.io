import 'package:agenda_front/ui/buttons/my_text_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LinksBar extends StatelessWidget {
  const LinksBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
        height: (size.width > 1000) ? size.height * 0.07 : null,
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            MyTextButton(
                text: 'About',
                onPressed: () {
                  if (kDebugMode) {
                    print('about');
                  }
                }),
            const MyTextButton(text: 'Help Center'),
            const MyTextButton(text: 'Terms of Service'),
            const MyTextButton(text: 'Privacy Policy'),
            const MyTextButton(text: 'Cookie Policy'),
            const MyTextButton(text: 'Ads info'),
            const MyTextButton(text: 'Blog'),
            const MyTextButton(text: 'Status'),
            const MyTextButton(text: 'Careers'),
            const MyTextButton(text: 'Brand Resources'),
            const MyTextButton(text: 'Advertising'),
            const MyTextButton(text: 'Marketing'),
          ],
        ));
  }
}
