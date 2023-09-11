import 'package:flutter/material.dart';

class MyIndex extends StatefulWidget {
  final List<DataColumn> columns;
  final DataTableSource source;
  final Widget? header;
  final List<Widget>? actions;
  const MyIndex(
      {super.key,
      required this.columns,
      required this.source,
      this.header,
      this.actions});

  @override
  State<MyIndex> createState() => _MyIndexState();
}

class _MyIndexState extends State<MyIndex> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      columns: widget.columns,
      source: widget.source,
      header: widget.header,
      actions: widget.actions,
      onRowsPerPageChanged: (value) {
        setState(() {
          _rowsPerPage = value ?? 10;
        });
      },
      rowsPerPage: _rowsPerPage,
      availableRowsPerPage: [_rowsPerPage],
    );
  }
}
