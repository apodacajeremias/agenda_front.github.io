// ignore_for_file: constant_identifier_names

import 'package:agenda_front/src/models/security/permission.dart';

enum Role {
  USER([]),
  ADMIN([
    Permission.ADMIN_READ,
    Permission.ADMIN_UPDATE,
    Permission.ADMIN_DELETE,
    Permission.ADMIN_CREATE,
    Permission.MANAGER_READ,
    Permission.MANAGER_UPDATE,
    Permission.MANAGER_DELETE,
    Permission.MANAGER_CREATE
  ]),
  MANAGER([
    Permission.MANAGER_READ,
    Permission.MANAGER_UPDATE,
    Permission.MANAGER_DELETE,
    Permission.MANAGER_CREATE
  ]);

  final List<Permission> permissions;

  const Role(this.permissions);
}
