// ignore_for_file: library_private_types_in_public_api

import 'package:agenda_front/datatables/users_datasource.dart';
import 'package:agenda_front/providers/usuario_provider.dart';
import 'package:agenda_front/ui/shared/indexs/index_footer.dart';
import 'package:agenda_front/ui/shared/indexs/index_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agenda_front/ui/buttons/custom_icon_button.dart';

class UsuarioIndexView extends StatefulWidget {
  const UsuarioIndexView({super.key});

  @override
  _UsuarioIndexViewState createState() => _UsuarioIndexViewState();
}

class _UsuarioIndexViewState extends State<UsuarioIndexView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<UsuarioProvider>(context, listen: false).buscarTodos();
  }

  @override
  Widget build(BuildContext context) {
    final usuarios = Provider.of<UsuarioProvider>(context).usuarios;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const IndexHeader(title: 'Usuarios'),
          const SizedBox(height: 10),
          PaginatedDataTable(
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Categoría')),
              DataColumn(label: Text('Creado por')),
              DataColumn(label: Text('Acciones')),
            ],
            source: UsersDataSource(usuarios, context),
            header: const Text('Categorías disponibles', maxLines: 2),
            onRowsPerPageChanged: (value) {
              setState(() {
                _rowsPerPage = value ?? 10;
              });
            },
            rowsPerPage: _rowsPerPage,
            actions: [
              CustomIconButton(
                onPressed: () {
                  // showModalBottomSheet(
                  //     backgroundColor: transparent,
                  //     context: context,
                  //     builder: (_) => const UsersModal(user: null));
                },
                text: 'Nuevo',
                icon: Icons.add_outlined,
              )
            ],
          ),
          const IndexFooter()
        ],
      ),
    );
  }
}
