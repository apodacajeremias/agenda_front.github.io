import 'package:agenda_front/providers.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/entities/movimiento.dart';
import 'package:agenda_front/ui/views/movimiento/movimiento_datasource.dart';
import 'package:agenda_front/ui/widgets/elevated_button.dart';
import 'package:agenda_front/ui/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovimientoIndexView extends StatefulWidget {
  final List<Movimiento>? data;
  const MovimientoIndexView({super.key, this.data});

  @override
  State<MovimientoIndexView> createState() => _MovimientoIndexViewState();
}

class _MovimientoIndexViewState extends State<MovimientoIndexView> {
  @override
  void initState() {
    widget.data ??
        Provider.of<MovimientoIndexProvider>(context, listen: false)
            .buscarTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data ??
        Provider.of<MovimientoIndexProvider>(context).movimientos;
    return Index(
      title: 'Pagos',
      columns: MovimientoDataSource.columns,
      source: MovimientoDataSource(data, context),
      actions: [
        EButton.registrar(
            onPressed: () => NavigationService.navigateTo(
                RouterService.movimientosCreateRoute))
      ],
    );
  }
}
