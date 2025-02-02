import 'dart:async';

import 'package:agenda_front/extensions.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _MySearchFormFieldState();
}

class _MySearchFormFieldState extends State<SearchField> {
  bool blink = false;
  bool inFocus = false;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (inFocus) {
        setState(() {
          blink = !blink;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    return Focus(
      onFocusChange: (value) {
        setState(() {
          inFocus = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: _width(context, inFocus),
        height: inFocus ? context.height * 0.06 : context.height * 0.05,
        curve: Curves.fastOutSlowIn,
        child: TextField(
            onSubmitted: (value) {
              // Provider.of<SearchProvider>(context, listen: false).query =
              //     value.trimAll();
            },
            onChanged: (value) {
              if (validateSearch(value)) {
                // Provider.of<SearchProvider>(context, listen: false).query =
                //     value.trimAll();
              }
            },
            decoration: InputDecoration(
              prefixIcon: _buildPrefixIcon(primary),
              suffixIcon: inFocus ? _buildSuffixIcon(primary) : null,
              fillColor: primary.withOpacity(0.1),
              filled: true,
              contentPadding: EdgeInsets.zero,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primary),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: blink ? primary.withOpacity(0.5) : primary,
                    width: 2.0),
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: 'Buscar',
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              border: const OutlineInputBorder(),
            )),
      ),
    );
  }

  Widget _buildSuffixIcon(Color primary) {
    return Icon(Icons.keyboard_return,
        color: blink ? primary.withOpacity(0.5) : primary);
  }

  Widget _buildPrefixIcon(Color primary) {
    return Icon(Icons.search,
        color: blink ? primary.withOpacity(0.5) : primary);
  }

  bool validateSearch(String value) {
    if (value.length % 2 == 0) {
      return true;
    }
    if (value.endsWith(' ')) {
      return true;
    }
    return false;
  }

  double _width(BuildContext context, bool inFocus) {
    return context.isDesktop
        ? (inFocus ? 400 : 150)
        : (inFocus ? context.width * 0.6 : context.width * 0.3);
  }
}
