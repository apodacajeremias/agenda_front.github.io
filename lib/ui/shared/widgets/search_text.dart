import 'package:flutter/material.dart';

import '../../inputs/custom_inputs.dart';

class SearchText extends StatelessWidget {
  final Color? color;
  const SearchText({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: buildBoxDecoration(),
      child: TextField(
        decoration: CustomInputs.form(
            label: 'Buscar', hint: 'Realice su búsqueda', icon: Icons.search),
        style: TextStyle(color: color),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() =>
      BoxDecoration(borderRadius: BorderRadius.circular(10));
}
