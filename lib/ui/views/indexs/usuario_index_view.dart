import 'package:agenda_front/datasources/user_datasource.dart';
import 'package:agenda_front/providers/usuario_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/ui/shared/indexs/my_index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsuarioIndexView extends StatefulWidget {
  const UsuarioIndexView({super.key});

  @override
  State<UsuarioIndexView> createState() => _UsuarioIndexViewState();
}

class _UsuarioIndexViewState extends State<UsuarioIndexView> {
  @override
  void initState() {
    Provider.of<UsuarioProvider>(context, listen: false).buscarTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<UsuarioProvider>(context).usuarios;
    return MyIndex(
        title: 'Users',
        columns: UserDataSource.columns,
        source: UserDataSource(data, context),
        createRoute: Flurorouter.usersCreateRoute);
  }
}
