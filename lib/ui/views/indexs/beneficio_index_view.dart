import 'package:agenda_front/datasources/beneficio_datasource.dart';
import 'package:agenda_front/providers/beneficio_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/ui/shared/indexs/my_index.dart';
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
    return MyIndex(
        title: 'Beneficios',
        columns: BeneficioDataSource.columns,
        source: BeneficioDataSource(data, context),
        createRoute: Flurorouter.beneficiosCreateRoute);
  }
}
