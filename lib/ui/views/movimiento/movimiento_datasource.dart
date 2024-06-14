import 'package:agenda_front/constants.dart';
import 'package:agenda_front/extensions.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/entities/movimiento.dart';
import 'package:agenda_front/src/models/entities/movimiento_detalle.dart';
import 'package:flutter/material.dart';

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
        if (movimiento.estado == null) ...[
          IconButton(
            onPressed: () {
              NavigationService.navigateTo('/movimientos/${movimiento.id}');
            },
            icon: const Icon(Icons.edit_rounded),
          ),
        ] else ...[
          if (movimiento.estado!) ...[
            IconButton(
              onPressed: () {
                NavigationService.navigateTo(
                    '/movimientos/${movimiento.id}/imprimir');
              },
              icon: const Icon(Icons.print_rounded),
            ),
          ] else ...[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.remove_red_eye_rounded),
            ),
          ]
        ]
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
    const DataColumn(label: Text('Subtotal')),
    const DataColumn(label: Text('')),
  ];

  @override
  DataRow? getRow(int index) {
    final detalle = detalles[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(index.toString())),
      DataCell(Text(detalle.subtotal.toString())),
      DataCell(Row(children: [
        IconButton(
            onPressed: () {
              showAdaptiveDialog(
                context: context,
                builder: (context) {
                  return Dialog(child: Placeholder());
                },
              );
            },
            icon: const Icon(Icons.edit_rounded)),
        const SizedBox(width: defaultSizing),
        IconButton(
            onPressed: () {
              print('delete pressed');
            },
            icon: const Icon(Icons.delete_forever_rounded)),
      ])),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => detalles.length;

  @override
  int get selectedRowCount => 0;
}
