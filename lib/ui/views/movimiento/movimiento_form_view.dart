import 'package:agenda_front/constants.dart';
import 'package:agenda_front/enums.dart';
import 'package:agenda_front/providers.dart';
import 'package:agenda_front/src/models/entities/movimiento.dart';
import 'package:agenda_front/translate.dart';
import 'package:agenda_front/ui/custom_inputs.dart';
import 'package:agenda_front/ui/views/movimiento/movimiento_datasource.dart';
import 'package:agenda_front/ui/views/persona/persona_dropdown.dart';
import 'package:agenda_front/ui/widgets/elevated_button.dart';
import 'package:agenda_front/ui/widgets/form_footer.dart';
import 'package:agenda_front/ui/widgets/form_header.dart';
import 'package:agenda_front/ui/widgets/index_body.dart';
import 'package:agenda_front/ui/widgets/index_header.dart';
import 'package:agenda_front/ui/widgets/white_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class MovimientoFormView extends StatelessWidget {
  final Movimiento? movimiento;
  const MovimientoFormView({super.key, this.movimiento});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovimientoFormProvider>(context);
    return ListView(children: [
      FormHeader(
          title: movimiento?.id == null
              ? AppLocalizations.of(context)!.movimiento('registrar')
              : AppLocalizations.of(context)!.movimiento('ver')),
      WhiteCard(
          child: FormBuilder(
              key: provider.formKey,
              child: Column(children: [
                if (movimiento?.id != null) ...[
                  const SizedBox(height: defaultSizing),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: FormBuilderTextField(
                            name: 'id',
                            initialValue: movimiento!.id,
                            enabled: false,
                            decoration: CustomInputs.form(
                                label: AppLocalizations.of(context)!.idTag,
                                hint: AppLocalizations.of(context)!.idHint,
                                icon: Icons.qr_code_rounded),
                          )),
                      const SizedBox(width: defaultSizing),
                      Expanded(
                          child: FormBuilderCheckbox(
                        name: '-estado',
                        initialValue: movimiento!.estado,
                        enabled: false,
                        title: Text(AppLocalizations.of(context)!.estadoHint),
                        decoration: CustomInputs.form(
                            label: AppLocalizations.of(context)!.actigoTag,
                            hint: AppLocalizations.of(context)!.estadoHint,
                            icon: Icons.qr_code_rounded),
                      )),
                    ],
                  )
                ],
                const SizedBox(height: defaultSizing),
                FormBuilderDropdown(
                    name: 'tipo',
                    enabled: false,
                    initialValue: movimiento?.tipo ?? TipoMovimiento.INGRESO,
                    decoration: CustomInputs.form(
                        label: AppLocalizations.of(context)!.tipo('movimiento'),
                        hint: AppLocalizations.of(context)!.tipo('movimiento'),
                        icon: Icons.info),
                    validator: FormBuilderValidators.required(
                        errorText:
                            AppLocalizations.of(context)!.campoObligatorio),
                    items: TipoMovimiento.values
                        .map((e) => DropdownMenuItem(
                            value: e, child: Text(e.toString())))
                        .toList()),
                const SizedBox(height: defaultSizing),
                PersonaSearchableDropdown(
                    name: 'persona',
                    unique: movimiento?.persona,
                    onChanged: (p) async {
                      if (p != null) {
                        double dp = await Provider.of<PersonaProvider>(context,
                                listen: false)
                            .deudaPendiente(p.id);
                        provider
                            .formKey.currentState!.fields['-deudaPendiente']!
                            .didChange(dp.toString());
                      } else {
                        provider
                            .formKey.currentState!.fields['-deudaPendiente']!
                            .didChange('0');
                      }
                    }),
                const SizedBox(height: defaultSizing),
                FormBuilderDropdown(
                    name: 'medioPago',
                    enabled: false,
                    initialValue: movimiento?.medioPago ?? MedioPago.EFECTIVO,
                    decoration: CustomInputs.form(
                        label:
                            AppLocalizations.of(context)!.tipo('transaccion'),
                        hint: AppLocalizations.of(context)!.tipo('transaccion'),
                        icon: Icons.info),
                    validator: FormBuilderValidators.required(
                        errorText:
                            AppLocalizations.of(context)!.campoObligatorio),
                    items: MedioPago.values
                        .map((e) => DropdownMenuItem(
                            value: e, child: Text(e.toString())))
                        .toList()),
                const SizedBox(height: defaultSizing),
                FormBuilderDropdown(
                    name: 'moneda',
                    enabled: false,
                    initialValue: movimiento?.moneda ?? Moneda.GUARANI,
                    decoration: CustomInputs.form(
                        label:
                            AppLocalizations.of(context)!.tipo('transaccion'),
                        hint: AppLocalizations.of(context)!.tipo('transaccion'),
                        icon: Icons.info),
                    validator: FormBuilderValidators.required(
                        errorText:
                            AppLocalizations.of(context)!.campoObligatorio),
                    items: Moneda.values
                        .map((e) => DropdownMenuItem(
                            value: e, child: Text(e.toString())))
                        .toList()),
                const SizedBox(height: defaultSizing),
                FormBuilderTextField(
                  name: '-deudaPendiente',
                  initialValue: 0.toString(),
                  decoration: CustomInputs.noBorder(
                      label: AppLocalizations.of(context)!.deudaPendiente,
                      hint: AppLocalizations.of(context)!.deudaPendiente,
                      icon: Icons.attach_money_rounded),
                ),
                const SizedBox(height: defaultSizing),
                FormBuilderTextField(
                  name: 'total',
                  initialValue: (movimiento?.total ?? 0).toString(),
                  decoration: CustomInputs.form(
                      label: AppLocalizations.of(context)!.valor,
                      hint: AppLocalizations.of(context)!.valor,
                      icon: Icons.payments_rounded),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.numeric(
                        errorText: AppLocalizations.of(context)!.soloNumeros),
                    FormBuilderValidators.required(
                        errorText:
                            AppLocalizations.of(context)!.campoObligatorio)
                  ]),
                ),
                FormFooter(onConfirm: () async {
                  try {
                    if (provider.formKey.currentState!.saveAndValidate()) {
                      final data = provider.formKey.currentState!.value;
                      await provider.registrar(data);
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    }
                  } catch (e) {
                    rethrow;
                  }
                })
              ]))),
      if (movimiento != null) ...[_MovimientoDetallesIndex(movimiento!)]
    ]);
  }
}

class _MovimientoDetallesIndex extends StatelessWidget {
  final Movimiento movimiento;
  const _MovimientoDetallesIndex(this.movimiento);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IndexHeader(title: AppLocalizations.of(context)!.detalles),
        IndexBody(
            title: AppLocalizations.of(context)!.detalles,
            columns: MovimientoDetalleDataSource.columns,
            actions: [
              EButton(
                text: AppLocalizations.of(context)!.movimiento('eliminar'),
                icon: Icons.hide_source_rounded,
                onPressed: () {
                  print('anular movimiento pressed');
                },
              )
            ],
            source: MovimientoDetalleDataSource(
                movimiento, movimiento.detalles ?? [], context))
      ],
    );
  }
}
