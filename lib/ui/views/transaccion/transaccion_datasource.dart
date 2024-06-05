import 'package:agenda_front/constants.dart';
import 'package:agenda_front/extensions.dart';
import 'package:agenda_front/providers.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/entities/transaccion.dart';
import 'package:agenda_front/src/models/entities/transaccion_detalle.dart';
import 'package:agenda_front/ui/views/transaccion_detalle_modal.dart';
import 'package:agenda_front/ui/widgets/elevated_button.dart';
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
    const DataColumn(label: Text('Acciones')),
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
        IconButton(
          onPressed: () {
            NavigationService.navigateTo('/transacciones/${transaccion.id}');
          },
          icon: const Icon(Icons.edit),
        ),
        IconButton(
            onPressed: () {
              final dialog = AlertDialog(
                  title: const Text('Estas seguro de borrarlo?'),
                  content: Text('Borrar transaccion $transaccion.nombre?'),
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
                              await Provider.of<TransaccionProvider>(context,
                                      listen: false)
                                  .eliminar(transaccion.id);
                          if (confirmado) {
                            NotificationService.showSnackbar(
                                'Transaccion eliminada exitosamente');
                          } else {
                            NotificationService.showSnackbar(
                                'Transaccion no ha sido eliminada');
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
        EButton.icon(
            icon: Icons.edit_rounded,
            onPressed: () {
              print('Editar detalle pressed');
              showAdaptiveDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: TransaccionDetalleModal(
                        transaccion: transaccion, detalle: detalle),
                  );
                },
              );
            }),
        const SizedBox(width: defaultSizing),
        EButton.icon(
            icon: Icons.delete_forever_rounded,
            onPressed: () {
              print('Eliminar detalle pressed');
            }),
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
