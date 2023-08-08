import 'package:flutter/material.dart';

import '../../inputs/custom_inputs.dart';

class SearchText extends StatelessWidget {
  const SearchText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: buildBoxDecoration(),
      child: TextField(
        decoration: CustomInputs.form(
            label: 'Buscar', hint: 'Realice su búsqueda', icon: Icons.search),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() =>
      BoxDecoration(borderRadius: BorderRadius.circular(10));
}
