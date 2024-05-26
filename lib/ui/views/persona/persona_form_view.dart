import 'package:agenda_front/constants.dart';
import 'package:agenda_front/providers.dart';
import 'package:agenda_front/src/models/entities/persona.dart';
import 'package:agenda_front/src/models/enums/genero.dart';
import 'package:agenda_front/translate.dart';
import 'package:agenda_front/ui/custom_inputs.dart';
import 'package:agenda_front/ui/widgets/form_footer.dart';
import 'package:agenda_front/ui/widgets/form_header.dart';
import 'package:agenda_front/ui/widgets/white_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PersonaFormView extends StatelessWidget {
  final Persona? persona;
  const PersonaFormView({super.key, this.persona});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PersonaProvider>(context, listen: false);
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        const FormHeader(title: 'Agendar'),
        WhiteCard(
            child: FormBuilder(
          key: provider.formKey,
          child: Column(
            children: [
              const SizedBox(height: defaultSizing),
              FormBuilderTextField(
                name: 'nombre',
                initialValue: persona?.nombre,
                decoration: CustomInputs.form(
                    label: AppLocalizations.of(context)!.nombreTag,
                    hint: AppLocalizations.of(context)!.nombreHint,
                    icon: Icons.supervised_user_circle_sharp),
                validator: FormBuilderValidators.required(
                    errorText: AppLocalizations.of(context)!.nombreObligatorio),
              ),
              const SizedBox(height: defaultSizing),
              FormBuilderTextField(
                name: 'documentoIdentidad',
                initialValue: persona?.documentoIdentidad,
                decoration: CustomInputs.form(
                    label: AppLocalizations.of(context)!.documentoIdentidadTag,
                    hint: AppLocalizations.of(context)!.documentoIdentidadTag,
                    icon: Icons.info_outline),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.integer(
                      errorText: AppLocalizations.of(context)!.soloNumeros),
                  FormBuilderValidators.required(
                      errorText: AppLocalizations.of(context)!.campoObligatorio)
                ]),
              ),
              const SizedBox(height: defaultSizing),
              FormBuilderDateTimePicker(
                  name: 'fechaNacimiento',
                  initialDate: persona?.fechaNacimiento,
                  format: dateFormat,
                  initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                  decoration: CustomInputs.form(
                      hint: AppLocalizations.of(context)!.fechaNacimientoTag,
                      label: AppLocalizations.of(context)!.fechaNacimientoTag,
                      icon: Icons.cake_outlined),
                  validator: FormBuilderValidators.required(
                      errorText: 'Campo obligatorio'),
                  inputType: InputType.date,
                  valueTransformer: (value) => value?.toIso8601String()),
              const SizedBox(height: defaultSizing),
              FormBuilderDropdown(
                name: 'genero',
                initialValue: persona?.genero,
                decoration: CustomInputs.form(
                    label: AppLocalizations.of(context)!.generoTag,
                    hint: AppLocalizations.of(context)!.generoTag,
                    icon: Icons.info_outline),
                items: Genero.values
                    .map((e) => DropdownMenuItem(
                        value: e,
                        child:
                            Text('${toBeginningOfSentenceCase(e.toString())}')))
                    .toList(),
                validator: FormBuilderValidators.required(
                    errorText: 'Campo obligatorio'),
                valueTransformer: (value) => value?.name,
              ),
              const SizedBox(height: defaultSizing),
              FormBuilderTextField(
                name: 'telefono',
                initialValue: persona?.telefono,
                decoration: CustomInputs.form(
                    label: AppLocalizations.of(context)!.telefonoTag,
                    hint: AppLocalizations.of(context)!.telefonoHint,
                    icon: Icons.info_outline),
                validator: FormBuilderValidators.integer(
                    errorText: AppLocalizations.of(context)!.soloNumeros),
              ),
              const SizedBox(height: defaultSizing),
              FormBuilderTextField(
                name: 'celular',
                initialValue: persona?.celular,
                decoration: CustomInputs.form(
                    label: AppLocalizations.of(context)!.celularTag,
                    hint: AppLocalizations.of(context)!.celularHint,
                    icon: Icons.info_outline),
                validator: FormBuilderValidators.integer(
                    errorText: AppLocalizations.of(context)!.soloNumeros),
              ),
              const SizedBox(height: defaultSizing),
              FormBuilderTextField(
                  name: 'direccion',
                  initialValue: persona?.direccion,
                  decoration: CustomInputs.form(
                      label: AppLocalizations.of(context)!.direccionTag,
                      hint: AppLocalizations.of(context)!.direccionTag,
                      icon: Icons.info_outline)),
              const SizedBox(height: defaultSizing),
              FormBuilderTextField(
                  name: 'observacion',
                  initialValue: persona?.observacion,
                  decoration: CustomInputs.form(
                      label: AppLocalizations.of(context)!.observacionesTag,
                      hint: AppLocalizations.of(context)!.observacionesTag,
                      icon: Icons.info_outline)),
            ],
          ),
        )),
        FormFooter(onConfirm: () async {
          try {
            // await provider.registrar();
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          } catch (e) {
            rethrow;
          }
        })
      ],
    );
  }
}
