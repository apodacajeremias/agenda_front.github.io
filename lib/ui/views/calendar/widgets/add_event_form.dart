import 'package:agenda_front/translate.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../app_colors.dart';
import '../constants.dart';
import '../extension.dart';
import 'custom_button.dart';
import 'date_time_selector.dart';

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

  @override
  void initState() {
    super.initState();

    _setDefaults();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AgendaProvider>(context, listen: false);
   return Container(
      padding: const EdgeInsets.all(defaultSizing),
      child: ListView(
        children: [
          FormHeader(
              title: item?.id == null
                  ? AppLocalizations.of(context)!.agenda('agregar')
                  : AppLocalizations.of(context)!.agenda('actualizar')),
          WhiteCard(
              child: FormBuilder(
                  key: provider.formKey,
                  child: Column(
                    children: [
                      
                      const SizedBox(height: defaultSizing),
                      PersonaSearchableDropdown(
                          name: 'persona',
                          //initialValue: item?.nombre,
                          enabled: item?.estado ?? true,
                          decoration: CustomInputs.form(
                              label: AppLocalizations.of(context)!.persona('asignar'),
                              hint: AppLocalizations.of(context)!.persona('asignar'),
                              icon: Icons.info),
                          validator: FormBuilderValidators.required(
                              errorText: AppLocalizations.of(context)!
                                  .campoObligatorio)),
                      const SizedBox(height: defaultSizing),
                      ColaboradorSearchableDropdown(
                          name: 'colaborador',
                          //initialValue: item?.nombre,
                          enabled: item?.estado ?? true,
                          decoration: CustomInputs.form(
                              label: AppLocalizations.of(context)!.colaborador('asignar'),
                              hint: AppLocalizations.of(context)!.colaborador('asignar'),
                              icon: Icons.info),
                          validator: FormBuilderValidators.required(
                              errorText: AppLocalizations.of(context)!
                                  .campoObligatorio)),
                      const SizedBox(height: defaultSizing),
                      FormBuilderDateTimePicker(
                        name: 'inicio',
                        // format: FechaUtil.dateFormat,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        decoration: CustomInputs.form(
                            hint: 'Inicio', label: 'Inicio', icon: Icons.event),
                        validator:
                            FormBuilderValidators.required(errorText: 'Campo obligatorio'),
                        inputType: InputType.date,
                        valueTransformer: (value) => value?.toIso8601String()),
                      const SizedBox(height: defaultSizing),
                      FormBuilderTextField(
                        name: 'observacion',
                        initialValue: item?.observacion,
                        keyboardType: TextInputType.multiline,
                        minLines: 2,
                        maxLines: 5,
                        decoration: CustomInputs.form(
                            label:
                                AppLocalizations.of(context)!.observacionesTag,
                            hint:
                                AppLocalizations.of(context)!.observacionesTag,
                            icon: Icons.comment_rounded),
                      ),
                      const SizedBox(height: defaultSizing),
                      FormFooter(onConfirm: () async {
                        if (provider.saveAndValidate()) {
                          try {
                            await provider.registrar(provider.formData());
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          } catch (e) {
                            rethrow;
                          }
                        }
                      })
                    ],
                  )))
        ],
      ),
    );
  }

  void _createEvent() {
    if (!(_form.currentState?.validate() ?? true)) return;

    _form.currentState?.save();

    final event = CalendarEventData(
      date: _startDate,
      endTime: _endTime,
      startTime: _startTime,
      endDate: _endDate,
      color: _color,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
    );

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
    _titleController.text = event.title;
    _descriptionController.text = event.description ?? '';
  }

  void _resetForm() {
    _form.currentState?.reset();
    _startDate = DateTime.now().withoutTime;
    _endDate = DateTime.now().withoutTime;
    _startTime = null;
    _endTime = null;
    _color = Colors.blue;

    if (mounted) {
      setState(() {});
    }
  }

  void _displayColorPicker() {
    var color = _color;
    showDialog(
      context: context,
      useSafeArea: true,
      barrierColor: Colors.black26,
      builder: (_) => SimpleDialog(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        contentPadding: EdgeInsets.all(20.0),
        children: [
          Text(
            "Select event color",
            style: TextStyle(
              color: AppColors.black,
              fontSize: 25.0,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            height: 1.0,
            color: AppColors.bluishGrey,
          ),
          ColorPicker(
            displayThumbColor: true,
            enableAlpha: false,
            pickerColor: _color,
            onColorChanged: (c) {
              color = c;
            },
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 50.0, bottom: 30.0),
              child: CustomButton(
                title: "Select",
                onTap: () {
                  if (mounted) {
                    setState(() {
                      _color = color;
                    });
                  }
                  context.pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
