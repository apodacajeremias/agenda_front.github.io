import 'package:agenda_front/constants.dart';
import 'package:agenda_front/enums.dart';
import 'package:agenda_front/providers.dart';
import 'package:agenda_front/src/models/dto/horario_disponible.dart';
import 'package:agenda_front/src/models/entities/colaborador.dart';
import 'package:agenda_front/src/models/entities/persona.dart';
import 'package:agenda_front/translate.dart';
import 'package:agenda_front/ui/custom_inputs.dart';
import 'package:agenda_front/ui/views/colaborador/colaborador_dropdown.dart';
import 'package:agenda_front/ui/views/persona/persona_dropdown.dart';
import 'package:agenda_front/ui/widgets/form_footer.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

// import '../app_colors.dart';
// import '../extension.dart';
// import 'custom_button.dart';

class AddOrEditEventForm extends StatefulWidget {
  final void Function(CalendarEventData)? onEventAdd;
  final CalendarEventData? event;

  const AddOrEditEventForm({
    super.key,
    this.onEventAdd,
    this.event,
  });

  @override
  _AddOrEditEventFormState createState() => _AddOrEditEventFormState();
}

class _AddOrEditEventFormState extends State<AddOrEditEventForm> {
  late DateTime _startDate = DateTime.now().withoutTime;
  late DateTime _endDate = DateTime.now().withoutTime;

  DateTime? _startTime;
  DateTime? _endTime;
  Color _color = Colors.blue;

  Persona? persona;
  Colaborador? colaborador;
  Duracion? duracion;
  DateTime? fecha;
  HorarioDisponible? horario;
  List<HorarioDisponible> horariosDisponibles = [];

  @override
  void initState() {
    super.initState();
    // _setDefaults();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AgendaFormProvider>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(defaultSizing),
      child: ListView(
        shrinkWrap: true,
        children: [
          FormBuilder(
              key: provider.formKey,
              child: Column(children: [
                const SizedBox(height: defaultSizing),
                PersonaSearchableDropdown(
                    name: 'persona',
                    onChanged: (value) {
                      setState(() {
                        persona = value;
                        colaborador = null;
                        duracion = null;
                        fecha = null;
                        horario = null;
                        horariosDisponibles = [];
                        provider.formKey.currentState!.fields['colaborador']
                            ?.didChange(null);
                      });
                    }),
                if (persona != null) ...[
                  const SizedBox(height: defaultSizing),
                  ColaboradorSearchableDropdown(
                      name: 'colaborador',
                      onChanged: (value) {
                        setState(() {
                          colaborador = value;
                          horario = null;
                          horariosDisponibles = [];
                          duracion = Duracion.quince_minutos;
                          provider.formKey.currentState!.fields['duracion']
                              ?.didChange(duracion);
                          // fecha = DateTime.now().add(const Duration(days: 1));
                          fecha = null;
                          provider.formKey.currentState!.fields['-fecha']
                              ?.didChange(fecha);
                          provider
                              .formKey.currentState!.fields['horarioDisponible']
                              ?.didChange(null);
                        });
                      }),
                ],
                if (colaborador != null) ...[
                  const SizedBox(height: defaultSizing),
                  FormBuilderDropdown(
                      name: 'duracion',
                      initialValue: Duracion.quince_minutos,
                      decoration: CustomInputs.form(
                          label: AppLocalizations.of(context)!.duracion,
                          hint: AppLocalizations.of(context)!.duracion,
                          icon: Icons.info),
                      items: Duracion.values
                          .map((e) => DropdownMenuItem(
                              value: e, child: Text(e.toString())))
                          .toList(),
                      validator: FormBuilderValidators.required(
                          errorText:
                              AppLocalizations.of(context)!.campoObligatorio),
                      valueTransformer: (value) => value?.duracion,
                      onChanged: (value) async {
                        duracion = value;
                        fecha = provider
                            .formKey.currentState!.fields['-fecha']?.value;
                        horariosDisponibles = [];
                        if (colaborador != null &&
                            fecha != null &&
                            duracion != null) {
                          horariosDisponibles =
                              await provider.horariosDisponibles(
                                  colaborador!.id, fecha!, duracion!);
                        }
                        setState(() {
                          horario = null;
                          provider
                              .formKey.currentState!.fields['horarioDisponible']
                              ?.didChange(null);
                        });
                      }),
                  const SizedBox(height: defaultSizing),
                  FormBuilderDateTimePicker(
                      name: '-fecha',
                      firstDate: DateTime.now(),
                      decoration: CustomInputs.form(
                          hint: AppLocalizations.of(context)!.fecha,
                          label: AppLocalizations.of(context)!.fecha,
                          icon: Icons.event),
                      validator: FormBuilderValidators.required(
                          errorText: 'Campo obligatorio'),
                      inputType: InputType.date,
                      valueTransformer: (value) => value?.toIso8601String(),
                      onChanged: (value) async {
                        duracion = provider
                            .formKey.currentState!.fields['duracion']?.value;
                        fecha = value;
                        horariosDisponibles = [];
                        if (colaborador != null &&
                            fecha != null &&
                            duracion != null) {
                          horariosDisponibles =
                              await provider.horariosDisponibles(
                                  colaborador!.id, fecha!, duracion!);
                        }
                        setState(() {
                          horario = null;
                          provider
                              .formKey.currentState!.fields['horarioDisponible']
                              ?.didChange(null);
                        });
                      }),
                ],
                if (horariosDisponibles.isNotEmpty) ...[
                  const SizedBox(height: defaultSizing),
                  FormBuilderDropdown(
                    name: 'horarioDisponible',
                    // initialValue: horariosDisponibles.first,
                    decoration: CustomInputs.form(
                        label: AppLocalizations.of(context)!.horarioDisponible,
                        hint: AppLocalizations.of(context)!.horarioDisponible,
                        icon: Icons.info),
                    items: horariosDisponibles
                        .map((e) => DropdownMenuItem(
                            value: e, child: Text(e.toHourMinute(context))))
                        .toList(),
                    validator: FormBuilderValidators.required(
                        errorText:
                            AppLocalizations.of(context)!.campoObligatorio),
                    // valueTransformer: (value) =>
                    //     {'inicio': value?.inicio, 'fin': value?.fin},
                    onChanged: (value) {
                      setState(() {
                        horario = value;
                      });
                    },
                  )
                ],
                if (horario != null) ...[
                  const SizedBox(height: defaultSizing),
                  FormBuilderDropdown(
                    name: 'prioridad',
                    initialValue: Prioridad.MEDIA,
                    decoration: CustomInputs.form(
                        label: AppLocalizations.of(context)!.prioridad,
                        hint: AppLocalizations.of(context)!.prioridad,
                        icon: Icons.info),
                    items: Prioridad.values
                        .map((e) => DropdownMenuItem(
                            value: e, child: Text(e.toString())))
                        .toList(),
                    validator: FormBuilderValidators.required(
                        errorText:
                            AppLocalizations.of(context)!.campoObligatorio),
                    valueTransformer: (value) => value!.name,
                  ),
                  const SizedBox(height: defaultSizing),
                  FormBuilderTextField(
                    name: 'observacion',
                    initialValue: widget.event?.description,
                    keyboardType: TextInputType.multiline,
                    minLines: 2,
                    maxLines: 5,
                    decoration: CustomInputs.form(
                        label: AppLocalizations.of(context)!.observacionesTag,
                        hint: AppLocalizations.of(context)!.observacionesTag,
                        icon: Icons.comment_rounded),
                  ),
                  const SizedBox(height: defaultSizing),
                  FormFooter(onConfirm: () async {
                    if (provider.formKey.currentState!.saveAndValidate()) {
                      try {
                        final event = await provider.registrar();
                        _createEvent(event);
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      } catch (e) {
                        rethrow;
                      }
                    }
                  })
                ],
              ]))
        ],
      ),
    );
  }

  void _createEvent(CalendarEventData event) {
    // final event = CalendarEventData(
    //   date: _startDate,
    //   endTime: _endTime,
    //   startTime: _startTime,
    //   endDate: _endDate,
    //   color: _color,
    //   title: 'pruebaaaaaaaa',
    //   // description: _descriptionController.text.trim(),
    // );

    widget.onEventAdd?.call(event);
    _resetForm();
  }

  void _setDefaults() {
    if (widget.event == null) return;

    final event = widget.event!;

    _startDate = event.date;
    _endDate = event.endDate;
    _startTime = event.startTime ?? _startTime;
    _endTime = event.endTime ?? _endTime;
    // _titleController.text = event.title;
    // _descriptionController.text = event.description ?? '';
  }

  void _resetForm() {
    // _form.currentState?.reset();
    _startDate = DateTime.now().withoutTime;
    _endDate = DateTime.now().withoutTime;
    _startTime = null;
    _endTime = null;
    _color = Colors.blue;

    if (mounted) {
      setState(() {});
    }
  }

  // void _displayColorPicker() {
  //   var color = _color;
  //   showDialog(
  //     context: context,
  //     useSafeArea: true,
  //     barrierColor: Colors.black26,
  //     builder: (_) => SimpleDialog(
  //       clipBehavior: Clip.hardEdge,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(20.0),
  //       ),
  //       contentPadding: EdgeInsets.all(20.0),
  //       children: [
  //         Text(
  //           "Select event color",
  //           style: TextStyle(
  //             color: AppColors.black,
  //             fontSize: 25.0,
  //           ),
  //         ),
  //         Container(
  //           margin: const EdgeInsets.symmetric(vertical: 20.0),
  //           height: 1.0,
  //           color: AppColors.bluishGrey,
  //         ),
  //         ColorPicker(
  //           displayThumbColor: true,
  //           enableAlpha: false,
  //           pickerColor: _color,
  //           onColorChanged: (c) {
  //             color = c;
  //           },
  //         ),
  //         Center(
  //           child: Padding(
  //             padding: EdgeInsets.only(top: 50.0, bottom: 30.0),
  //             child: CustomButton(
  //               title: "Select",
  //               onTap: () {
  //                 if (mounted) {
  //                   setState(() {
  //                     _color = color;
  //                   });
  //                 }
  //                 context.pop();
  //               },
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
