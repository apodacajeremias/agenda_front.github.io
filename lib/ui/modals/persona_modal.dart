import 'package:agenda_front/models/persona.dart';
import 'package:agenda_front/providers/personas_provider.dart';
import 'package:agenda_front/services/notifications_service.dart';
import 'package:agenda_front/ui/buttons/custom_outlined_button.dart';
import 'package:agenda_front/ui/inputs/custom_inputs.dart';
import 'package:agenda_front/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonaModal extends StatefulWidget {
  final Persona? persona;

  const PersonaModal({Key? key, this.persona}) : super(key: key);

  @override
  _PersonaModalState createState() => _PersonaModalState();
}

class _PersonaModalState extends State<PersonaModal> {
  String nombre = '';
  String documentoIdentidad = '';
  String genero = '';
  String direccion = '';
  String? id;

  @override
  void initState() {
    super.initState();

    id = widget.persona?.id;
    nombre = widget.persona?.nombre ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final personaProvider =
        Provider.of<PersonasProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(20),
      height: 900,
      width: 300, // expanded
      decoration: buildBoxDecoration(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.persona?.nombre ?? 'Nueva categoría',
                    style: CustomLabels.h1.copyWith(color: Colors.white)),
                IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.of(context).pop())
              ],
            ),
            Divider(color: Colors.white.withOpacity(0.3)),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: widget.persona?.nombre ?? '',
              onChanged: (value) => nombre = value,
              decoration: CustomInputs.loginInputDecoration(
                  hint: 'Nombre completo',
                  label: 'Nombre',
                  icon: Icons.new_releases_outlined),
              style: const TextStyle(color: Colors.white),
            ),
            TextFormField(
              initialValue: widget.persona?.documentoIdentidad ?? '',
              onChanged: (value) => documentoIdentidad = value,
              decoration: CustomInputs.loginInputDecoration(
                  hint: 'Documento',
                  label: 'Documento de Identidad',
                  icon: Icons.new_releases_outlined),
              style: const TextStyle(color: Colors.white),
            ),
            TextFormField(
              initialValue: widget.persona?.genero ?? '',
              onChanged: (value) => genero = value,
              decoration: CustomInputs.loginInputDecoration(
                  hint: 'Genero',
                  label: 'Genero',
                  icon: Icons.new_releases_outlined),
              style: const TextStyle(color: Colors.white),
            ),
            TextFormField(
              initialValue: widget.persona?.direccion ?? '',
              onChanged: (value) => direccion = value,
              decoration: CustomInputs.loginInputDecoration(
                  hint: 'Direccion de domicilio',
                  label: 'Direccion',
                  icon: Icons.new_releases_outlined),
              style: const TextStyle(color: Colors.white),
            ),
            TextFormField(
              initialValue: widget.persona?.nombre ?? '',
              onChanged: (value) => nombre = value,
              decoration: CustomInputs.loginInputDecoration(
                  hint: 'Nombre de la categoría',
                  label: 'Categoría',
                  icon: Icons.new_releases_outlined),
              style: const TextStyle(color: Colors.white),
            ),
            TextFormField(
              initialValue: widget.persona?.nombre ?? '',
              onChanged: (value) => nombre = value,
              decoration: CustomInputs.loginInputDecoration(
                  hint: 'Nombre de la categoría',
                  label: 'Categoría',
                  icon: Icons.new_releases_outlined),
              style: const TextStyle(color: Colors.white),
            ),
            TextFormField(
              initialValue: widget.persona?.nombre ?? '',
              onChanged: (value) => nombre = value,
              decoration: CustomInputs.loginInputDecoration(
                  hint: 'Nombre de la categoría',
                  label: 'Categoría',
                  icon: Icons.new_releases_outlined),
              style: const TextStyle(color: Colors.white),
            ),
            TextFormField(
              initialValue: widget.persona?.nombre ?? '',
              onChanged: (value) => nombre = value,
              decoration: CustomInputs.loginInputDecoration(
                  hint: 'Nombre de la categoría',
                  label: 'Categoría',
                  icon: Icons.new_releases_outlined),
              style: const TextStyle(color: Colors.white),
            ),
            TextFormField(
              initialValue: widget.persona?.nombre ?? '',
              onChanged: (value) => nombre = value,
              decoration: CustomInputs.loginInputDecoration(
                  hint: 'Nombre de la categoría',
                  label: 'Categoría',
                  icon: Icons.new_releases_outlined),
              style: const TextStyle(color: Colors.white),
            ),
            TextFormField(
              initialValue: widget.persona?.nombre ?? '',
              onChanged: (value) => nombre = value,
              decoration: CustomInputs.loginInputDecoration(
                  hint: 'Nombre de la categoría',
                  label: 'Categoría',
                  icon: Icons.new_releases_outlined),
              style: const TextStyle(color: Colors.white),
            ),
            TextFormField(
              initialValue: widget.persona?.nombre ?? '',
              onChanged: (value) => nombre = value,
              decoration: CustomInputs.loginInputDecoration(
                  hint: 'Nombre de la categoría',
                  label: 'Categoría',
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
                      // Crear
                      await personaProvider.newPersona(nombre);
                      NotificationsService.showSnackbar('$nombre creado!');
                    } else {
                      // Actualizar
                      await personaProvider.updatePersona(id!, nombre);
                      NotificationsService.showSnackbar('$nombre Actualizado!');
                    }

                    Navigator.of(context).pop();
                  } catch (e) {
                    Navigator.of(context).pop();
                    NotificationsService.showSnackbarError(
                        'No se pudo guardar la categoría');
                  }
                },
                text: 'Guardar',
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      color: Color(0xff0F2041),
      boxShadow: [BoxShadow(color: Colors.black26)]);
}
