import 'package:agenda_front/constants.dart';
import 'package:agenda_front/extensions.dart';
import 'package:agenda_front/providers.dart';
import 'package:agenda_front/src/models/entities/item.dart';
import 'package:agenda_front/src/models/entities/transaccion.dart';
import 'package:agenda_front/src/models/entities/transaccion_detalle.dart';
import 'package:agenda_front/src/models/enums/tipo_beneficio.dart';
import 'package:agenda_front/src/models/enums/tipo_descuento.dart';
import 'package:agenda_front/src/models/enums/tipo_transaccion.dart';
import 'package:agenda_front/translate.dart';
import 'package:agenda_front/ui/custom_inputs.dart';
import 'package:agenda_front/ui/views/persona/persona_dropdown.dart';
import 'package:agenda_front/ui/views/transaccion/transaccion_datasource.dart';
import 'package:agenda_front/ui/widgets/elevated_button.dart';
import 'package:agenda_front/ui/widgets/form_footer.dart';
import 'package:agenda_front/ui/widgets/form_header.dart';
import 'package:agenda_front/ui/widgets/index_body.dart';
import 'package:agenda_front/ui/widgets/white_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class TransaccionFormView extends StatelessWidget {
  final Transaccion? transaccion;
  const TransaccionFormView({super.key, this.transaccion});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransaccionProvider>(context, listen: false);
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        FormHeader(
            title: transaccion?.id == null
                ? AppLocalizations.of(context)!.transaccion('registrar')
                : AppLocalizations.of(context)!.transaccion('editar')),
        WhiteCard(
            child: FormBuilder(
          child: Column(
            children: [
              // TODO: falta agregar grupo, beneficio
              if (transaccion?.id != null) ...[
                const SizedBox(height: defaultSizing),
                FormBuilderTextField(
                  name: 'id',
                  initialValue: transaccion?.id,
                  enabled: false,
                  decoration: CustomInputs.form(
                      label: AppLocalizations.of(context)!.idTag,
                      hint: AppLocalizations.of(context)!.idHint,
                      icon: Icons.qr_code_rounded),
                ),
              ],
              const SizedBox(height: defaultSizing),
              PersonaSearchableDropdown(
                name: 'persona',
                unique: transaccion?.persona,
              ),
              const SizedBox(height: defaultSizing),
              FormBuilderDropdown(
                  name: 'tipo',
                  initialValue: transaccion?.tipo,
                  decoration: CustomInputs.form(
                      label: AppLocalizations.of(context)!.tipo('transaccion'),
                      hint: AppLocalizations.of(context)!.tipo('transaccion'),
                      icon: Icons.info),
                  validator: FormBuilderValidators.required(
                      errorText:
                          AppLocalizations.of(context)!.campoObligatorio),
                  items: TipoTransaccion.values
                      .map((e) =>
                          DropdownMenuItem(value: e, child: Text(e.toString())))
                      .toList()),
              const SizedBox(height: defaultSizing),
              FormBuilderDropdown(
                  name: 'tipoBeneficio',
                  initialValue: transaccion?.tipoBeneficio,
                  decoration: CustomInputs.form(
                      label: AppLocalizations.of(context)!.tipo('beneficio'),
                      hint: AppLocalizations.of(context)!.tipo('beneficio'),
                      icon: Icons.info),
                  validator: FormBuilderValidators.required(
                      errorText:
                          AppLocalizations.of(context)!.campoObligatorio),
                  items: TipoBeneficio.values
                      .map((e) =>
                          DropdownMenuItem(value: e, child: Text(e.toString())))
                      .toList()),
              const SizedBox(height: defaultSizing),
              FormBuilderDropdown(
                  name: 'tipoDescuento',
                  initialValue: transaccion?.tipoDescuento,
                  decoration: CustomInputs.form(
                      label: AppLocalizations.of(context)!.tipo('descuento'),
                      hint: AppLocalizations.of(context)!.tipo('descuento'),
                      icon: Icons.info),
                  validator: FormBuilderValidators.required(
                      errorText:
                          AppLocalizations.of(context)!.campoObligatorio),
                  items: TipoDescuento.values
                      .map((e) =>
                          DropdownMenuItem(value: e, child: Text(e.toString())))
                      .toList()),
              const SizedBox(height: defaultSizing),
              FormBuilderCheckbox(
                name: 'aplicarDescuento',
                title: Text(AppLocalizations.of(context)!.aplicarDescuento),
                initialValue: transaccion?.aplicarPromocion,
                decoration: CustomInputs.form(
                    label: AppLocalizations.of(context)!.aplicarDescuento,
                    hint: AppLocalizations.of(context)!.aplicarDescuento,
                    icon: Icons.info),
              ),
              const SizedBox(height: defaultSizing),
              FormBuilderTextField(
                name: 'sumatoria',
                initialValue:
                    transaccion?.sumatoria?.toString() ?? 0.toString(),
                decoration: CustomInputs.form(
                    label: AppLocalizations.of(context)!.sumatoriaTotal,
                    hint: AppLocalizations.of(context)!.sumatoriaTotal,
                    icon: Icons.info),
                validator: FormBuilderValidators.required(
                    errorText: AppLocalizations.of(context)!.campoObligatorio),
              ),
              const SizedBox(height: defaultSizing),
              FormBuilderTextField(
                name: 'descuento',
                initialValue:
                    transaccion?.descuento?.toString() ?? 0.toString(),
                decoration: CustomInputs.form(
                    label: AppLocalizations.of(context)!.descuento,
                    hint: AppLocalizations.of(context)!.descuento,
                    icon: Icons.info),
                validator: FormBuilderValidators.required(
                    errorText: AppLocalizations.of(context)!.campoObligatorio),
              ),
              const SizedBox(height: defaultSizing),
              FormBuilderTextField(
                name: 'total',
                initialValue: transaccion?.total?.toString() ?? 0.toString(),
                decoration: CustomInputs.form(
                    label: AppLocalizations.of(context)!.totalPagar,
                    hint: AppLocalizations.of(context)!.totalPagar,
                    icon: Icons.info),
                validator: FormBuilderValidators.required(
                    errorText: AppLocalizations.of(context)!.campoObligatorio),
              ),
              const SizedBox(height: defaultSizing),
              if (transaccion != null) ...[
                Text(AppLocalizations.of(context)!.detalles,
                    style: context.headlineLarge),
                const SizedBox(height: defaultSizing),
                const SizedBox(height: defaultSizing),
                IndexBody(
                    title: AppLocalizations.of(context)!.detalles,
                    columns: TransaccionDetalleDataSource.columns,
                    actions: [
                      EButton(
                        text: AppLocalizations.of(context)!.accion('agregar'),
                        icon: Icons.add_rounded,
                        onPressed: () {
                          debugPrint('Abrir modal para buscar item');
                        },
                      )
                    ],
                    source: TransaccionDetalleDataSource(
                        transaccion!.detalles ??
                            [
                              TransaccionDetalle(
                                  item: Item(
                                      nombre: AppLocalizations.of(context)!
                                          .items(0)),
                                  cantidad: 0,
                                  valor: 0,
                                  subtotal: 0)
                            ],
                        context))
              ]
            ],
          ),
        )),
        FormFooter(onConfirm: () async {
          try {
            if (provider.formKey.currentState!.saveAndValidate()) {
              final data = provider.formKey.currentState!.value;
              await provider.registrar();
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            }
          } catch (e) {
            rethrow;
          }
        })
      ],
    );
  }
}
