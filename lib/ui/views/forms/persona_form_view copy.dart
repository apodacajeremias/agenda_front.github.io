// import 'package:agenda_front/models/persona.dart';
// import 'package:agenda_front/providers/persona_provider.dart';
// import 'package:agenda_front/services/fecha_util.dart';
// import 'package:agenda_front/services/notifications_service.dart';
// import 'package:agenda_front/ui/buttons/custom_outlined_button.dart';
// import 'package:agenda_front/ui/cards/white_card.dart';
// import 'package:agenda_front/ui/inputs/custom_inputs.dart';
// import 'package:agenda_front/ui/labels/custom_labels.dart';
// import 'package:email_validator/email_validator.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// class PersonaFormView extends StatefulWidget {
//   final Persona persona;

//   const PersonaFormView({super.key, required this.persona});

//   @override
//   State<PersonaFormView> createState() => _PersonaFormViewState();
// }

// class _PersonaFormViewState extends State<PersonaFormView> {
//   late TextEditingController _date;

//   @override
//   void initState() {
//     super.initState();
//     _date = TextEditingController(
//         text: FechaUtil.formatDate(widget.persona.fechaNacimiento ?? DateTime.now()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final personaProvider =
//         Provider.of<PersonaProvider>(context, listen: false);
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: ListView(
//         physics: const ClampingScrollPhysics(),
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('Formulario de Persona', style: CustomLabels.h1),
//               IconButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                   icon: const Icon(Icons.close, color: Colors.white))
//             ],
//           ),
//           WhiteCard(
//             title: widget.persona.nombre ?? 'Registro nuevo',
//             child: Form(
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 key: personaProvider.formKey,
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 10),
//                     TextFormField(
//                         initialValue: widget.persona.nombre,
//                         onChanged: (value) => widget.persona.nombre = value,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'El nombre es obligatorio';
//                           }
//                           return null;
//                         },
//                         decoration: CustomInputs.loginInputDecoration(
//                             hint: 'Ingrese nombre y apellido',
//                             label: 'Nombre completo',
//                             icon: Icons.person_pin,
//                             color: Colors.black)),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                         controller: _date,
//                         onChanged: (value) {
//                           DateTime parsedDate =
//                               FechaUtil.parseDate(value);
//                           widget.persona.fechaNacimiento = parsedDate;
//                         },
//                         onTap: () {
//                           showDatePicker(
//                                   context: context,
//                                   initialDate: widget.persona.fechaNacimiento ??
//                                       DateTime.now(),
//                                   firstDate: DateTime(1900),
//                                   lastDate: DateTime(2101))
//                               .then((value) {
//                             if (value != null) {
//                               setState(() {
//                                 _date.text =
//                                     (DateFormat('dd/MM/yyyy').format(value));
//                                 widget.persona.fechaNacimiento = value;
//                               });
//                             }
//                           });
//                         },
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'La fecha de nacimiento es obligatorio';
//                           }
//                           final selectedDate = FechaUtil.parseDate(value);
//                           if (selectedDate == null) {
//                             return 'Ingrese una fecha válida';
//                           }
//                           if (selectedDate.isAfter(DateTime.now())) {
//                             return 'La fecha de nacimiento no puede ser hoy ni después';
//                           }
//                           if (selectedDate.isAfter(DateTime.now())) {
//                             return 'La fecha de nacimiento no puede ser hoy ni después';
//                           }
//                           final yearsDifference =
//                               DateTime.now().difference(selectedDate).inDays ~/
//                                   365;
//                           if (yearsDifference > 150) {
//                             return 'Ingrese una fecha de nacimiento válida';
//                           }
//                           return null;
//                         },
//                         decoration: CustomInputs.loginInputDecoration(
//                             hint: 'Ingrese fecha de nacimiento',
//                             label: 'Fecha de Nacimiento',
//                             icon: Icons.calendar_today_rounded,
//                             color: Colors.black)),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                         onChanged: (value) =>
//                             widget.persona.documentoIdentidad = value,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'El documento de identidad es obligatorio';
//                           }
//                           return null;
//                         },
//                         decoration: CustomInputs.loginInputDecoration(
//                             hint: 'Ingrese documento de identidad',
//                             label: 'Documento de Identidad',
//                             icon: Icons.badge,
//                             color: Colors.black)),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                         onChanged: (value) => widget.persona.telefono = value,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'El telefono es obligatorio';
//                           }
//                           return null;
//                         },
//                         decoration: CustomInputs.loginInputDecoration(
//                             hint: 'Ingrese telefono de contacto',
//                             label: 'Telefono de contacto',
//                             icon: Icons.phone,
//                             color: Colors.black)),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                         onChanged: (value) => widget.persona.correo = value,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return null;
//                           }
//                           if (!EmailValidator.validate(value)) {
//                             return 'Ingrese un correo valido';
//                           }
//                           return null;
//                         },
//                         decoration: CustomInputs.loginInputDecoration(
//                             hint: 'Ingrese correo electronico',
//                             label: 'Correo electronico',
//                             icon: Icons.email,
//                             color: Colors.black)),
//                     Container(
//                       margin: const EdgeInsets.only(top: 30),
//                       alignment: Alignment.center,
//                       child: CustomOutlinedButton(
//                           onPressed: () async {
//                             try {
//                               if (widget.persona.id == null) {
//                                 await personaProvider
//                                     .newPersona(widget.persona);
//                                 NotificationsService.showSnackbar(
//                                     'Registro de $widget.persona.nombre creado!');
//                               } else {
//                                 await personaProvider.updatePersona(
//                                     widget.persona.id!, widget.persona);
//                                 NotificationsService.showSnackbar(
//                                     'Registro de $widget.persona.nombre modificado!');
//                               }
//                               Navigator.of(context).pop;
//                             } catch (e) {
//                               Navigator.of(context).pop;
//                               NotificationsService.showSnackbarError(
//                                   'No se pudo guardar la persona');
//                               rethrow;
//                             }
//                           },
//                           text: 'Guardar'),
//                     )
//                   ],
//                 )),
//           )
//         ],
//       ),
//     );
//   }
// }
