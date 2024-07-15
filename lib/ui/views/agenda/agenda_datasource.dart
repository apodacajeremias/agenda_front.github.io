import 'package:agenda_front/constants.dart';
import 'package:agenda_front/extensions.dart';
import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/entities/agenda.dart';
import 'package:agenda_front/src/models/entities/agenda_detalle.dart';
import 'package:flutter/material.dart';

class AgendaDataSource extends DataTableSource {
  final List<Agenda> agendas;
  final BuildContext context;

  AgendaDataSource(this.agendas, this.context);

  static List<DataColumn> columns = [
    const DataColumn(label: Text('Persona')),
    const DataColumn(label: Text('Colaborador')),
    const DataColumn(label: Text('Inicio')),
    const DataColumn(label: Text('Fin')),
    const DataColumn(label: Text('Acciones')),
  ];

  @override
  DataRow? getRow(int index) {
    final agenda = agendas[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(agenda.persona.nombre)),
      DataCell(Text(agenda.colaborador.nombre)),
      DataCell(Text(agenda.inicio.formatDateTime())),
      DataCell(Text(agenda.fin.formatDateTime())),
      DataCell(Row(children: [
        IconButton(
          onPressed: () {
            NavigationService.navigateTo('/agendas/${agenda.id}');
          },
          icon: const Icon(Icons.edit),
        ),
      ]))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => agendas.length;

  @override
  int get selectedRowCount => 0;
}

class AgendaDataSourceProfile extends DataTableSource {
  final List<Agenda> agendas;
  final BuildContext context;

  AgendaDataSourceProfile(this.agendas, this.context);

  static List<DataColumn> columns = [
    const DataColumn(label: Text('Colaborador')),
    const DataColumn(label: Text('Inicio')),
    const DataColumn(label: Text('Fin')),
  ];

  @override
  DataRow? getRow(int index) {
    final agenda = agendas[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(agenda.colaborador.nombre)),
      DataCell(Text(agenda.inicio.formatDateTime())),
      DataCell(Text(agenda.fin.formatDateTime())),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => agendas.length;

  @override
  int get selectedRowCount => 0;
}

class AgendaDetalleDataSource extends DataTableSource {
  final List<AgendaDetalle> detalles;
  final BuildContext context;

  AgendaDetalleDataSource(this.detalles, this.context);

  static List<DataColumn> columns = [
    const DataColumn(label: Text('Detalle')),
    const DataColumn(label: Text('Observaciones')),
  ];

  @override
  DataRow? getRow(int index) {
    final detalle = detalles[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(
        Column(
          children: [
            Text(detalle.nombre),
            Text(
                '${detalle.fechaCreacion.dateToStringWithFormat(format: "dd/MM/yyyy")} ${timeFormat.format(detalle.fechaCreacion)}'),
          ],
        ),
      ),
      DataCell(
        Text(detalle.observacion ?? "Sin observaciones."),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => detalles.length;

  @override
  int get selectedRowCount => 0;
}
