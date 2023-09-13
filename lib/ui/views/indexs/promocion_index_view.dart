import 'package:agenda_front/datasources/promocion_datasource.dart';
import 'package:agenda_front/providers/promocion_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/ui/buttons/my_elevated_button.dart';
import 'package:agenda_front/ui/shared/indexs/my_index.dart';
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
    return MyIndex(
      title: 'Promociones',
      columns: PromocionDataSource.columns,
      source: PromocionDataSource(data, context),
      actions: [
        MyElevatedButton.create(
            onPressed: () => NavigationService.navigateTo(
                Flurorouter.promocionesCreateRoute))
      ],
    );
  }
}
