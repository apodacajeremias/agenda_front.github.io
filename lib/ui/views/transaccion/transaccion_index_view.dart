import 'package:agenda_front/providers.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/entities/transaccion.dart';
import 'package:agenda_front/ui/views/transaccion/transaccion_datasource.dart';
import 'package:agenda_front/ui/widgets/elevated_button.dart';
import 'package:agenda_front/ui/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransaccionIndexView extends StatefulWidget {
  final List<Transaccion>? data;
  const TransaccionIndexView({super.key, this.data});

  @override
  State<TransaccionIndexView> createState() => _TransaccionIndexViewState();
}

class _TransaccionIndexViewState extends State<TransaccionIndexView> {
  @override
  void initState() {
    widget.data ??
        Provider.of<TransaccionProvider>(context, listen: false).buscarTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data =
        widget.data ?? Provider.of<TransaccionProvider>(context).transacciones;
    return Index(
      title: 'Transacciones',
      columns: TransaccionDataSource.columns,
      source: TransaccionDataSource(data, context),
      actions: [
        EButton.create(
            onPressed: () => NavigationService.navigateTo(
                RouterService.transaccionesCreateRoute))
      ],
    );
  }
}
