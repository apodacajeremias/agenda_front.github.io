import 'package:agenda_front/ui/widgets/index_footer.dart';
import 'package:agenda_front/ui/widgets/index_header.dart';
import 'package:flutter/material.dart';

class IndexBody extends StatefulWidget {
  final String title;
  final String? subtitle;
  final List<DataColumn> columns;
  final DataTableSource source;
  final List<Widget>? actions;

  const IndexBody(
      {super.key,
      required this.title,
      this.subtitle,
      required this.columns,
      required this.source,
      this.actions});

  @override
  State<IndexBody> createState() => _IndexBodyState();
}

class _IndexBodyState extends State<IndexBody> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        IndexHeader(title: widget.title),
        PaginatedDataTable(
          columns: widget.columns,
          source: widget.source,
          actions: widget.actions,
          header: Text(widget.subtitle ?? 'Listado',
              style: Theme.of(context).textTheme.titleMedium),
          onRowsPerPageChanged: (value) {
            setState(() {
              _rowsPerPage = value ?? 10;
            });
          },
          rowsPerPage: _rowsPerPage,
        ),
        const IndexFooter()
      ],
    );
  }
}
