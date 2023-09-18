import 'package:agenda_front/models/security/user.dart';
import 'package:flutter/material.dart';

import 'package:agenda_front/services/navigation_service.dart';

class UserDataSource extends DataTableSource {
  final List<User> users;
  final BuildContext context;

  UserDataSource(this.users, this.context);

  static List<DataColumn> columns = const [
    DataColumn(label: Text('ID')),
    DataColumn(label: Text('Correo')),
    DataColumn(label: Text('Rol')),
    DataColumn(label: Text('Acciones')),
  ];

  @override
  DataRow getRow(int index) {
    final User user = users[index];
    const image =
        Image(image: AssetImage('no-image.jpg'), width: 35, height: 35);
    return DataRow.byIndex(index: index, cells: [
      const DataCell(ClipOval(child: image)),
      DataCell(Text(user.id!)),
      DataCell(Text(user.email!)),
      DataCell(Text(user.role!)),
      DataCell(IconButton(
          icon: const Icon(Icons.edit),
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
