import 'package:agenda_front/providers.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/ui/views/beneficio/beneficio_datasource.dart';
import 'package:agenda_front/ui/widgets/elevated_button.dart';
import 'package:agenda_front/ui/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BeneficioIndexView extends StatefulWidget {
  const BeneficioIndexView({super.key});

  @override
  State<BeneficioIndexView> createState() => _BeneficioIndexViewState();
}

class _BeneficioIndexViewState extends State<BeneficioIndexView> {
  @override
  void initState() {
    Provider.of<BeneficioProvider>(context, listen: false).buscarTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<BeneficioProvider>(context).beneficios;
    return Index(
      title: 'Beneficios',
      columns: BeneficioDataSource.columns,
      source: BeneficioDataSource(data, context),
      actions: [
        EButton.create(
            onPressed: () => NavigationService.navigateTo(
                RouterService.beneficiosCreateRoute))
      ],
    );
  }
}
