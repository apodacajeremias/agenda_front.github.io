import 'package:agenda_front/constants.dart';
import 'package:agenda_front/models/entities/persona.dart';
import 'package:agenda_front/models/enums/prioridad.dart';
import 'package:agenda_front/models/enums/situacion.dart';
import 'package:agenda_front/providers/agenda_provider.dart';
import 'package:agenda_front/ui/dropdown/colaborador_dropdown.dart';
import 'package:agenda_front/ui/dropdown/persona_dropdown.dart';
import 'package:agenda_front/ui/shared/forms/form_footer.dart';
import 'package:agenda_front/ui/shared/forms/form_header.dart';
import 'package:agenda_front/utils/fecha_util.dart';
import 'package:agenda_front/ui/cards/white_card.dart';
import 'package:agenda_front/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AgendaFormView extends StatelessWidget {
  const AgendaFormView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AgendaProvider>(context, listen: false);
    return SizedBox(
      height: double.maxFinite,
      width: double.maxFinite,
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const FormHeader(title: 'Agendar'),
          WhiteCard(
            child: _form(provider),
          ),
          FormFooter(onConfirm: () async {
            try {
              await provider.registrar();
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            } catch (e) {
              rethrow;
            }
          })
        ],
      ),
    );
  }
}

class AgendaFormDialog extends StatelessWidget {
  final Persona? persona;
  const AgendaFormDialog({super.key, this.persona});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AgendaProvider>(context, listen: false);
    return SizedBox(
      height: double.maxFinite,
      width: double.maxFinite,
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const FormHeader(title: 'Agendar'),
          _form(provider, persona: persona),
          FormFooter(onConfirm: () async {
            try {
              await provider.registrar();
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            } catch (e) {
              rethrow;
            }
          })
        ],
      ),
    );
  }
}

FormBuilder _form(AgendaProvider provider, {Persona? persona}) {
  return FormBuilder(
    key: provider.formKey,
    child: Column(
      children: [
        FormBuilderDateTimePicker(
            name: 'inicio',
            format: FechaUtil.dateFormat,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            decoration: CustomInputs.form(
                hint: 'Inicio', label: 'Inicio', icon: Icons.event),
            validator:
                FormBuilderValidators.required(errorText: 'Campo obligatorio'),
            inputType: InputType.both,
            valueTransformer: (value) => value?.toIso8601String()),
        const SizedBox(height: defaultPadding),
        FormBuilderDateTimePicker(
            name: 'fin',
            format: FechaUtil.timeFormat,
            initialTime: TimeOfDay.fromDateTime(DateTime.now()),
            decoration: CustomInputs.form(
                hint: 'Fin', label: 'Fin', icon: Icons.schedule),
            validator:
                FormBuilderValidators.required(errorText: 'Campo obligatorio'),
            inputType: InputType.both,
            valueTransformer: (value) => value?.toIso8601String()),
        const SizedBox(height: defaultPadding),
        PersonaSearchableDropdown(name: 'persona', onlyValue: persona),
        const SizedBox(height: defaultPadding),
        const ColaboradorSearchableDropdown(name: 'colaborador'),
        const SizedBox(height: defaultPadding),
        FormBuilderDropdown(
          name: 'situacion',
          initialValue: Situacion.PENDIENTE,
          items: [
            DropdownMenuItem(
                value: Situacion.PENDIENTE,
                child: Text(
                    '${toBeginningOfSentenceCase(Situacion.PENDIENTE.toString())}'))
          ],
          validator:
              FormBuilderValidators.required(errorText: 'Campo obligatorio'),
          valueTransformer: (value) => value?.name,
        ),
        const SizedBox(height: defaultPadding),
        FormBuilderDropdown(
          name: 'prioridad',
          initialValue: Prioridad.MEDIA,
          items: Prioridad.values
              .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text('${toBeginningOfSentenceCase(e.toString())}')))
              .toList(),
          validator:
              FormBuilderValidators.required(errorText: 'Campo obligatorio'),
          valueTransformer: (value) => value?.name,
        ),
        const SizedBox(height: defaultPadding),
        FormBuilderTextField(
          name: 'observacion',
          decoration: CustomInputs.form(
              label: 'Observaciones',
              hint: 'Escriba sus observaciones para el agendamiento',
              icon: Icons.notes),
          keyboardType: TextInputType.multiline,
          minLines: 2,
          maxLines: 5, //
        ),
      ],
    ),
  );
}
