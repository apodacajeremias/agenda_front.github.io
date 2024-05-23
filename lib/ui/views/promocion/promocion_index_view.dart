import 'package:agenda_front/providers.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/ui/views/promocion/promocion_datasource.dart';
import 'package:agenda_front/ui/widgets/elevated_button.dart';
import 'package:agenda_front/ui/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromocionIndexView extends StatefulWidget {
  const PromocionIndexView({super.key});

  @override
  State<PromocionIndexView> createState() => _PromocionIndexViewState();
}

class _PromocionIndexViewState extends State<PromocionIndexView> {
  @override
  void initState() {
    Provider.of<PromocionProvider>(context, listen: false).buscarTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<PromocionProvider>(context).promociones;
    return Index(
      title: 'Promociones',
      columns: PromocionDataSource.columns,
      source: PromocionDataSource(data, context),
      actions: [
        EButton.registrar(
            onPressed: () => NavigationService.navigateTo(
                RouterService.promocionesCreateRoute))
      ],
    );
  }
}
