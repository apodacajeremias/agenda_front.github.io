import 'package:agenda_front/constants.dart';
import 'package:agenda_front/extensions.dart';
import 'package:agenda_front/providers.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/entities/transaccion.dart';
import 'package:agenda_front/src/models/entities/transaccion_detalle.dart';
import 'package:agenda_front/ui/views/transaccion/transaccion_detalle_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransaccionDataSource extends DataTableSource {
  final List<Transaccion> transacciones;
  final BuildContext context;

  TransaccionDataSource(this.transacciones, this.context);

  static List<DataColumn> columns = [
    const DataColumn(label: Text('Persona')),
    const DataColumn(label: Text('Fecha')),
    const DataColumn(label: Text('Tipo')),
    const DataColumn(label: Text('Total')),
    const DataColumn(label: Text('')),
  ];

  @override
  DataRow? getRow(int index) {
    final transaccion = transacciones[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(transaccion.persona.nombre)),
      DataCell(Text(transaccion.fechaCreacion.formatDate())),
      DataCell(Text(transaccion.tipo.toString())),
      DataCell(Text(transaccion.total.toString())),
      DataCell(Row(children: [
        if (transaccion.estado == null) ...[
          IconButton(
            onPressed: () {
              NavigationService.navigateTo('/transacciones/${transaccion.id}');
            },
            icon: const Icon(Icons.edit_rounded),
          ),
        ] else ...[
          if (transaccion.estado!) ...[
            IconButton(
              onPressed: () {
                NavigationService.navigateTo(
                    '/transacciones/${transaccion.id}/print');
                // Provider.of<TransaccionFormProvider>(context, listen: false)
                //     .imprimir(transaccion.id);
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
  int get rowCount => transacciones.length;

  @override
  int get selectedRowCount => 0;
}

class TransaccionDataSourceProfile extends DataTableSource {
  final List<Transaccion> transacciones;
  final BuildContext context;

  TransaccionDataSourceProfile(this.transacciones, this.context);

  static List<DataColumn> columns = [
    const DataColumn(label: Text('Fecha')),
    const DataColumn(label: Text('Tipo')),
    const DataColumn(label: Text('Total'))
  ];

  @override
  DataRow? getRow(int index) {
    final transaccion = transacciones[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(transaccion.fechaCreacion.formatDate())),
      DataCell(Text(transaccion.tipo.toString())),
      DataCell(Text(transaccion.total.toString())),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => transacciones.length;

  @override
  int get selectedRowCount => 0;
}

class TransaccionDetalleDataSource extends DataTableSource {
  final Transaccion transaccion;
  final List<TransaccionDetalle> detalles;
  final BuildContext context;

  TransaccionDetalleDataSource(this.transaccion, this.detalles, this.context);

// TODO: longPress o doubleTap para editar detalle, click derecho menu contextual
  static List<DataColumn> columns = [
    const DataColumn(label: Text('#')),
    const DataColumn(label: Text('Item')),
    const DataColumn(label: Text('Cantidad')),
    const DataColumn(label: Text('Valor')),
    const DataColumn(label: Text('Subtotal')),
    const DataColumn(label: Text('')),
  ];

  @override
  DataRow? getRow(int index) {
    final detalle = detalles[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(index.toString())),
      DataCell(Text(detalle.item!.nombre)),
      DataCell(Text(detalle.cantidad!.toString())),
      DataCell(Text(detalle.valor!.toString())),
      DataCell(Text(detalle.subtotal!.toString())),
      DataCell(Row(children: [
        IconButton(
            onPressed: () {
              showAdaptiveDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: TransaccionDetalleModal(
                        transaccion: transaccion, detalle: detalle),
                  );
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
