// ignore_for_file: use_build_context_synchronously

import 'package:agenda_front/models/security/user.dart';
import 'package:agenda_front/providers/user_provider.dart';
import 'package:agenda_front/services/notifications_service.dart';
import 'package:agenda_front/ui/buttons/custom_outlined_button.dart';
import 'package:agenda_front/ui/inputs/custom_inputs.dart';
import 'package:agenda_front/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersModal extends StatefulWidget {
  final User? user;

  const UsersModal({super.key, this.user});

  @override
  State<UsersModal> createState() => _UsersModalState();
}

class _UsersModalState extends State<UsersModal> {
  String nombre = '';
  String? id;
  @override
  void initState() {
    super.initState();
    id = widget.user?.id;
    nombre = widget.user?.username ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UserProvider>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(25),
      height: 500,
      width: 300,
      decoration: buildBoxDecoration(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.user?.email ?? 'Nuevo User',
                  style: CustomLabels.h1.copyWith(color: Colors.white)),
              IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close_outlined, color: Colors.white))
            ],
          ),
          Divider(color: Colors.white.withOpacity(0.3)),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            initialValue: widget.user?.email,
            onChanged: (value) => nombre = value,
            decoration: CustomInputs.loginInputDecoration(
                hint: 'Nombre de la usuario',
                label: 'User',
                icon: Icons.new_releases_outlined),
            style: const TextStyle(color: Colors.white),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: CustomOutlinedButton(
              onPressed: () async {
                try {
                  if (id == null) {
                    //CREAR
                    await usuarioProvider.newUser(widget.user!);
                    NotificationsService.showSnackbar('$nombre creado!');
                  } else {
                    // Actualizar
                    await usuarioProvider.updateUser(id!, nombre);
                    NotificationsService.showSnackbar('$nombre actualizado!');
                  }
                  Navigator.of(context).pop;
                } catch (e) {
                  Navigator.of(context).pop;
                  NotificationsService.showSnackbarError(
                      'No se pudo guardar la usuario');
                }
              },
              text: 'Guardar',
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      color: Color(0xff0f2041),
      boxShadow: [BoxShadow(color: Colors.black26)]);
}
