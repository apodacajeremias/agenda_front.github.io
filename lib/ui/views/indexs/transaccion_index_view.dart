import 'package:agenda_front/datasources/transaccion_datasource.dart';
import 'package:agenda_front/providers/transaccion_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/ui/shared/indexs/my_index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransaccionIndexView extends StatefulWidget {
  const TransaccionIndexView({super.key});

  @override
  State<TransaccionIndexView> createState() => _TransaccionIndexViewState();
}

class _TransaccionIndexViewState extends State<TransaccionIndexView> {
  @override
  void initState() {
    Provider.of<TransaccionProvider>(context, listen: false).buscarTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<TransaccionProvider>(context).transacciones;
    return MyIndex(
        title: 'Transaccions',
        columns: TransaccionDataSource.columns,
        source: TransaccionDataSource(data, context),
        createRoute: Flurorouter.transaccionesCreateRoute);
  }
}
