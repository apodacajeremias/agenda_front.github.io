// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:agenda_front/constants.dart';
import 'package:agenda_front/extensions.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/entities/transaccion.dart';
import 'package:agenda_front/src/models/entities/transaccion_detalle.dart';
import 'package:agenda_front/ui/views/transaccion/transaccion_detalle_modal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

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

  void downloadFile(String url) {
    if (kIsWeb) {
      html.AnchorElement anchorElement = html.AnchorElement(href: url);
      anchorElement.download = url;
      anchorElement.click();
      anchorElement.remove();
    }
  }

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
              onPressed: () async {
                // NavigationService.navigateTo('/transacciones/${transaccion.id}/print');
                // Provider.of<TransaccionFormProvider>(context, listen: false).imprimir(transaccion.id);

                // final url =
                //     '${ServerConnection.baseurl}/transacciones/${transaccion.id}/imprimir';
                // final stream = get(Uri.parse(url));
                // download(stream, 'transaccion_${transaccion.id}.pdf');

                // final stream = ServerConnection.httpGet(
                //     '/transacciones/${transaccion.id}/imprimir');
                // print('The type of myObject is: ${stream.runtimeType}');
                // Future<int> futureInt = stream.then((value) {
                //   return int.tryParse(value.toString()) ??
                //       0; // Returns 0 if it's not an integer
                // });
                // download(Stream.fromFuture(futureInt),
                //     'transaccion_${transaccion.id}.pdf');

                // final stream = Stream.fromIterable('Hello World!'.codeUnits);
                // download(stream, 'hello.txt');

                // final url =
                //     '${ServerConnection.baseurl}/transacciones/${transaccion.id}/imprimir';
                // final stream = get(Uri.parse(url));
                // Future<int> futureInt = stream.then((value) {
                //   return int.tryParse(value.toString()) ??
                //       0; // Returns 0 if it's not an integer
                // });
                // download(Stream.fromFuture(futureInt), 'hello.pdf');

                // final response = await networkManager.downloadFileSimple(
                //     '${ServerConnection.baseurl}/transacciones/${transaccion.id}/imprimir',
                //     (count, total) {
                //   print('${count}');
                // });

                downloadFile(
                    '${ServerConnection.baseurl}/transacciones/${transaccion.id}/imprimir');
              },
              icon: const Icon(Icons.download_rounded),
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
