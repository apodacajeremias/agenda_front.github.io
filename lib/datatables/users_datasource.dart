import 'package:agenda_front/models/security/usuario.dart';
import 'package:flutter/material.dart';

import 'package:agenda_front/services/navigation_service.dart';

class UsersDataSource extends DataTableSource {
  final List<Usuario> users;
  final BuildContext context;

  UsersDataSource(this.users, this.context);

  @override
  DataRow getRow(int index) {
    final Usuario user = users[index];
    const image =
        Image(image: AssetImage('no-image.jpg'), width: 35, height: 35);
    return DataRow.byIndex(index: index, cells: [
      const DataCell(ClipOval(child: image)),
      DataCell(Text(user.id!)),
      DataCell(Text(user.email!)),
      DataCell(Text(user.role!)),
      DataCell(IconButton(
          icon: const Icon(Icons.edit_outlined),
          onPressed: () {
            NavigationService.replaceTo('/users/${user.id}');
          })),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => users.length;

  @override
  int get selectedRowCount => 0;
}
