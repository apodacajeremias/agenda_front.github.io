// ignore_for_file: prefer_const_constructors
import 'package:agenda_front/constants.dart';
import 'package:agenda_front/models/entities/promocion.dart';
import 'package:agenda_front/models/enums/tipo_descuento.dart';
import 'package:agenda_front/providers/promocion_provider.dart';
import 'package:agenda_front/ui/cards/white_card.dart';
import 'package:agenda_front/ui/inputs/custom_inputs.dart';
import 'package:agenda_front/ui/shared/forms/form_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PromocionFormView extends StatelessWidget {
  final Promocion? promocion;
  const PromocionFormView({super.key, this.promocion});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PromocionProvider>(context, listen: false);
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      child: ListView(
        children: [
          FormHeader(title: 'Promoción'),
          WhiteCard(
              child: FormBuilder(
                  key: provider.formKey,
                  child: Column(
                    children: [
                      if (promocion?.id != null) ...[
                        const SizedBox(height: defaultPadding),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: FormBuilderTextField(
                                  name: 'ID',
                                  initialValue: promocion?.id,
                                  enabled: false,
                                  decoration: CustomInputs.form(
                                      label: 'ID',
                                      hint: 'ID',
                                      icon: Icons.qr_code),
                                )),
                            const SizedBox(width: defaultPadding),
                            Expanded(
                                child: FormBuilderSwitch(
                              name: 'activo',
                              title: const Text('Estado del registro'),
                              initialValue: promocion?.activo,
                              decoration: CustomInputs.noBorder(),
                            )),
                          ],
                        )
                      ],
                      SizedBox(height: defaultPadding),
                      FormBuilderTextField(
                        name: 'nombre',
                        initialValue: promocion?.nombre,
                        enabled: promocion?.activo ?? true,
                        decoration: CustomInputs.form(
                            label: 'Nombre',
                            hint: 'Nombre para la promoción',
                            icon: Icons.info),
                        validator: FormBuilderValidators.required(
                            errorText: 'Campo obligatorio'),
                      ),
                      SizedBox(height: defaultPadding),
                      Row(
                        children: [
                          Expanded(
                              child: FormBuilderDateTimePicker(
                            name: 'inicio',
                            initialValue: promocion?.inicio,
                            enabled: promocion?.activo ?? true,
                            decoration: CustomInputs.form(
                                label: 'Fecha de Inicio',
                                hint: 'Inicio de promocion',
                                icon: Icons.schedule),
                            validator: FormBuilderValidators.required(
                                errorText: 'Campo obligatorio'),
                            valueTransformer: (value) =>
                                value?.toIso8601String(),
                            inputType: InputType.date,
                          )),
                          SizedBox(height: defaultPadding),
                          Expanded(
                              child: FormBuilderDateTimePicker(
                            name: 'fin',
                            initialValue: promocion?.fin,
                            enabled: promocion?.activo ?? true,
                            decoration: CustomInputs.form(
                                label: 'Fecha de Finalizacion',
                                hint: 'Fin de promocion',
                                icon: Icons.schedule),
                            validator: FormBuilderValidators.required(
                                errorText: 'Campo obligatorio'),
                            valueTransformer: (value) =>
                                value?.toIso8601String(),
                            inputType: InputType.date,
                          )),
                        ],
                      ),
                      SizedBox(height: defaultPadding),
                      Row(
                        children: [
                          Expanded(
                            child: FormBuilderTextField(
                              name: 'valor',
                              initialValue: promocion?.valor.toString(),
                              enabled: promocion?.activo ?? true,
                              decoration: CustomInputs.form(
                                  label: 'Valor',
                                  hint: 'Valor del descuento',
                                  icon: Icons.tag),
                              validator: FormBuilderValidators.required(
                                  errorText: 'Campo obligatorio'),
                            ),
                          ),
                          SizedBox(width: defaultPadding),
                          Expanded(
                            child: FormBuilderDropdown(
                              name: 'tipoDescuento',
                              initialValue: promocion?.tipoDescuento,
                              enabled: promocion?.activo ?? true,
                              decoration: CustomInputs.form(
                                  label: 'Tipo de descuento',
                                  hint: 'Tipo de descuento',
                                  icon: Icons.info),
                              items: TipoDescuento.values
                                  .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                          toBeginningOfSentenceCase(e.name)!)))
                                  .toList(),
                              validator: FormBuilderValidators.required(
                                  errorText: 'Tipo obligatorio'),
                              valueTransformer: (value) => value?.name,
                            ),
                          )
                        ],
                      )
                    ],
                  )))
        ],
      ),
    );
  }
}
