import 'package:agenda_front/extensions.dart';
import 'package:agenda_front/providers.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/entities/movimiento.dart';
import 'package:agenda_front/src/models/entities/movimiento_detalle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovimientoDataSource extends DataTableSource {
  final List<Movimiento> movimientos;
  final BuildContext context;

  MovimientoDataSource(this.movimientos, this.context);

  static List<DataColumn> columns = [
    const DataColumn(label: Text('Persona')),
    const DataColumn(label: Text('Fecha')),
    const DataColumn(label: Text('Tipo')),
    const DataColumn(label: Text('Total')),
    const DataColumn(label: Text('')),
  ];

  @override
  DataRow? getRow(int index) {
    final movimiento = movimientos[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(movimiento.persona.nombre)),
      DataCell(Text(movimiento.fechaCreacion.formatDate())),
      DataCell(Text(movimiento.tipo.toString())),
      DataCell(Text(movimiento.total.toString())),
      DataCell(Row(children: [
        IconButton(
          onPressed: () {
            NavigationService.navigateTo('/movimientos/${movimiento.id}');
          },
          icon: const Icon(Icons.edit),
        ),
        IconButton(
            onPressed: () {
              final dialog = AlertDialog(
                  title: const Text('Estas seguro de borrarlo?'),
                  content: Text('Borrar movimiento ${movimiento.nombre}?'),
                  actions: [
                    TextButton(
                      child: const Text('No, mantener'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                        child: const Text('Si, borrar'),
                        onPressed: () async {
                          var confirmado =
                              await Provider.of<MovimientoProvider>(context,
                                      listen: false)
                                  .eliminar(movimiento.id);
                          if (confirmado) {
                            NotificationService.showSnackbar(
                                'Movimiento eliminada exitosamente');
                          } else {
                            NotificationService.showSnackbar(
                                'Movimiento no ha sido eliminada');
                          }
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        }),
                  ]);
              showDialog(context: context, builder: (_) => dialog);
            },
            icon: const Icon(Icons.delete))
      ]))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => movimientos.length;

  @override
  int get selectedRowCount => 0;
}

class MovimientoDataSourceProfile extends DataTableSource {
  final List<Movimiento> movimientos;
  final BuildContext context;

  MovimientoDataSourceProfile(this.movimientos, this.context);

  static List<DataColumn> columns = [
    const DataColumn(label: Text('Fecha')),
    const DataColumn(label: Text('Tipo')),
    const DataColumn(label: Text('Total'))
  ];

  @override
  DataRow? getRow(int index) {
    final movimiento = movimientos[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(movimiento.fechaCreacion.formatDate())),
      DataCell(Text(movimiento.tipo.toString())),
      DataCell(Text(movimiento.total.toString())),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => movimientos.length;

  @override
  int get selectedRowCount => 0;
}

class MovimientoDetalleDataSource extends DataTableSource {
  final Movimiento movimiento;
  final List<MovimientoDetalle> detalles;
  final BuildContext context;

  MovimientoDetalleDataSource(this.movimiento, this.detalles, this.context);

// TODO: longPress o doubleTap para editar detalle, click derecho menu contextual
  static List<DataColumn> columns = [
    const DataColumn(label: Text('#')),
    const DataColumn(label: Text('Transacción')),
    const DataColumn(label: Text('Subtotal')),
  ];

  @override
  DataRow? getRow(int index) {
    final detalle = detalles[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(index.toString())),
      DataCell(Text(detalle.transaccion.nombre)),
      DataCell(Text(detalle.subtotal.toString())),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => detalles.length;

  @override
  int get selectedRowCount => 0;
}
