import 'package:agenda_front/constants.dart';
import 'package:agenda_front/enums.dart';
import 'package:agenda_front/extensions.dart';
import 'package:agenda_front/providers.dart';
import 'package:agenda_front/src/models/entities/beneficio.dart';
import 'package:agenda_front/src/models/entities/grupo.dart';
import 'package:agenda_front/src/models/entities/item.dart';
import 'package:agenda_front/src/models/entities/persona.dart';
import 'package:agenda_front/src/models/entities/promocion.dart';
import 'package:agenda_front/src/models/entities/transaccion.dart';
import 'package:agenda_front/src/models/entities/transaccion_detalle.dart';
import 'package:agenda_front/translate.dart';
import 'package:agenda_front/ui/custom_inputs.dart';
import 'package:agenda_front/ui/views/persona/persona_dropdown.dart';
import 'package:agenda_front/ui/views/transaccion/transaccion_datasource.dart';
import 'package:agenda_front/ui/views/transaccion/transaccion_detalle_modal.dart';
import 'package:agenda_front/ui/widgets/elevated_button.dart';
import 'package:agenda_front/ui/widgets/form_footer.dart';
import 'package:agenda_front/ui/widgets/form_header.dart';
import 'package:agenda_front/ui/widgets/index_body.dart';
import 'package:agenda_front/ui/widgets/white_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class TransaccionFormView extends StatefulWidget {
  final Transaccion? transaccion;
  const TransaccionFormView({super.key, this.transaccion});

  @override
  State<TransaccionFormView> createState() => _TransaccionFormViewState();
}

class _TransaccionFormViewState extends State<TransaccionFormView> {
  Persona? persona;
  Grupo? grupo;
  Beneficio? beneficio;
  Promocion? promocion;

  @override
  void initState() {
    persona = widget.transaccion?.persona;
    grupo = widget.transaccion?.grupo;
    beneficio = widget.transaccion?.beneficio;
    promocion = widget.transaccion?.promocion;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransaccionFormProvider>(context);
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        FormHeader(
            title: widget.transaccion?.id == null
                ? AppLocalizations.of(context)!.transaccion('registrar')
                : AppLocalizations.of(context)!.transaccion('editar')),
        WhiteCard(
            child: FormBuilder(
          key: provider.formKey,
          child: Column(
            children: [
              // TODO: falta agregar grupo, beneficio
              if (widget.transaccion?.id != null) ...[
                const SizedBox(height: defaultSizing),
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: FormBuilderTextField(
                          name: 'id',
                          initialValue: widget.transaccion!.id,
                          enabled: false,
                          decoration: CustomInputs.noBorder(
                              label: AppLocalizations.of(context)!.idTag,
                              hint: AppLocalizations.of(context)!.idHint,
                              icon: Icons.qr_code_rounded),
                        )),
                    const SizedBox(width: defaultSizing),
                    Expanded(
                      child: FormBuilderTextField(
                        name: 'tipo',
                        initialValue: widget.transaccion!.tipo.toString(),
                        enabled: false,
                        decoration: CustomInputs.noBorder(
                            label: AppLocalizations.of(context)!
                                .tipo('transaccion'),
                            hint: AppLocalizations.of(context)!
                                .tipo('transaccion'),
                            icon: Icons.info),
                        validator: FormBuilderValidators.required(
                            errorText:
                                AppLocalizations.of(context)!.campoObligatorio),
                      ),
                    ),
                    const SizedBox(width: defaultSizing),
                    if (widget.transaccion?.estado != null) ...[
                      Expanded(
                          child: FormBuilderTextField(
                        name: '-estado',
                        initialValue: widget.transaccion!.estado!
                            ? AppLocalizations.of(context)!.aprobado
                            : AppLocalizations.of(context)!.rechazado,
                        enabled: false,
                        decoration: CustomInputs.noBorder(),
                      )),
                    ] else ...[
                      Expanded(
                          child: EButton(
                        text: AppLocalizations.of(context)!.aprobar,
                        icon: Icons.check_circle_outline_rounded,
                        color: Colors.green,
                        onPressed: () async {
                          final sum = provider.formKey.currentState!
                              .fields['-sumatoria']!.value;
                          await provider.cambiarEstado(
                              widget.transaccion!.id, true);
                        },
                      )),
                      const SizedBox(width: defaultSizing),
                      Expanded(
                          child: EButton(
                        text: AppLocalizations.of(context)!.rechazar,
                        icon: Icons.cancel_outlined,
                        color: Colors.red,
                        onPressed: () async {
                          await provider.cambiarEstado(
                              widget.transaccion!.id, false);
                        },
                      )),
                    ]
                  ],
                )
              ],

              const SizedBox(height: defaultSizing),
              Row(
                children: [
                  if (widget.transaccion?.id == null) ...[
                    Expanded(
                      child: FormBuilderSearchableDropdown(
                        name: 'tipo',
                        initialValue:
                            widget.transaccion?.tipo ?? TipoTransaccion.VENTA,
                        decoration: CustomInputs.form(
                            label: AppLocalizations.of(context)!
                                .tipo('transaccion'),
                            hint: AppLocalizations.of(context)!
                                .tipo('transaccion'),
                            icon: Icons.info_rounded),
                        items: TipoTransaccion.values,
                        compareFn: (item1, item2) => item1 == item2,
                      ),
                    ),
                    const SizedBox(width: defaultSizing),
                  ],
                  Expanded(
                    flex: 2,
                    child: PersonaSearchableDropdown(
                      name: 'persona',
                      unique: widget.transaccion?.persona,
                      onChanged: (p) {
                        setState(() {
                          persona = p;
                          grupo = null;
                          beneficio = null;
                          promocion = null;
                          provider.formKey.currentState!.fields['grupo']
                              ?.didChange(null);
                          provider.formKey.currentState!.fields['beneficio']
                              ?.didChange(null);
                          provider.formKey.currentState!.fields['promocion']
                              ?.didChange(null);
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: defaultSizing),
                  if (persona?.grupos != null &&
                      persona!.grupos!.isNotEmpty) ...[
                    const SizedBox(height: defaultSizing),
                    Expanded(
                      child: FormBuilderSearchableDropdown(
                          name: 'grupo',
                          initialValue: grupo,
                          decoration: CustomInputs.form(
                              label: AppLocalizations.of(context)!
                                  .grupo('asignar'),
                              hint: AppLocalizations.of(context)!
                                  .grupo('asignar'),
                              icon: Icons.group),
                          items: persona!.grupos!,
                          compareFn: (item1, item2) =>
                              item1.id.contains(item2.id),
                          valueTransformer: (value) => value?.id,
                          onChanged: (value) {
                            setState(() {
                              grupo = value;
                              beneficio = null;
                              promocion = null;
                              provider.formKey.currentState!.fields['beneficio']
                                  ?.didChange(null);
                              provider.formKey.currentState!.fields['promocion']
                                  ?.didChange(null);
                            });
                          },
                          clearButtonProps:
                              const ClearButtonProps(isVisible: true)),
                    ),
                  ]
                ],
              ),

              if (persona?.grupos != null && persona!.grupos!.isNotEmpty) ...[
                if (grupo != null && grupo!.beneficio != null) ...[
                  const SizedBox(height: defaultSizing),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: FormBuilderSearchableDropdown(
                              name: 'beneficio',
                              initialValue: beneficio,
                              decoration: CustomInputs.form(
                                  label: AppLocalizations.of(context)!
                                      .beneficio('asignar'),
                                  hint: AppLocalizations.of(context)!
                                      .beneficio('asignar'),
                                  icon: Icons.group),
                              items: [grupo!.beneficio!],
                              compareFn: (item1, item2) =>
                                  item1.id.contains(item2.id),
                              valueTransformer: (value) => value?.id,
                              onChanged: (value) {
                                setState(() {
                                  beneficio = value;
                                  promocion = null;
                                  provider
                                      .formKey.currentState!.fields['promocion']
                                      ?.didChange(null);
                                });
                              },
                              clearButtonProps:
                                  const ClearButtonProps(isVisible: true))),
                      if (beneficio != null) ...[
                        const SizedBox(width: defaultSizing),
                        Expanded(
                          child: FormBuilderSearchableDropdown(
                              name: '-tipoBeneficio',
                              initialValue: beneficio?.tipo,
                              enabled: false,
                              decoration: CustomInputs.form(
                                  label: AppLocalizations.of(context)!
                                      .tipo('beneficio'),
                                  hint: AppLocalizations.of(context)!
                                      .tipo('beneficio'),
                                  icon: Icons.info),
                              validator: FormBuilderValidators.required(
                                  errorText: AppLocalizations.of(context)!
                                      .campoObligatorio),
                              items: TipoBeneficio.values,
                              compareFn: (item1, item2) => item1 == item2),
                        ),
                      ],
                      if (beneficio?.promociones != null &&
                          beneficio!.promociones!.isNotEmpty) ...[
                        const SizedBox(width: defaultSizing),
                        Expanded(
                          flex: 2,
                          child: FormBuilderSearchableDropdown(
                              name: 'promocion',
                              initialValue: promocion,
                              decoration: CustomInputs.form(
                                  label: AppLocalizations.of(context)!
                                      .promocion('asignar'),
                                  hint: AppLocalizations.of(context)!
                                      .promocion('asignar'),
                                  icon: Icons.group),
                              onChanged: (value) {
                                setState(() {
                                  promocion = value;
                                });
                              },
                              items: grupo!.beneficio!.promociones!,
                              compareFn: (item1, item2) =>
                                  item1.id.contains(item2.id),
                              valueTransformer: (value) => value?.id,
                              clearButtonProps:
                                  const ClearButtonProps(isVisible: true)),
                        )
                      ],
                      if (promocion != null || beneficio != null) ...[
                        const SizedBox(width: defaultSizing),
                        Expanded(
                          child: FormBuilderSearchableDropdown(
                              name: '-tipoDescuento',
                              initialValue: promocion?.tipoDescuento ??
                                  beneficio?.tipoDescuento,
                              enabled: (promocion != null || beneficio != null)
                                  ? false
                                  : true,
                              decoration: CustomInputs.form(
                                  label: AppLocalizations.of(context)!
                                      .tipo('descuento'),
                                  hint: AppLocalizations.of(context)!
                                      .tipo('descuento'),
                                  icon: Icons.info),
                              validator: FormBuilderValidators.required(
                                  errorText: AppLocalizations.of(context)!
                                      .campoObligatorio),
                              items: TipoDescuento.values,
                              compareFn: (item1, item2) => item1 == item2),
                        ),
                      ]
                    ],
                  )
                ],
              ],
              if (widget.transaccion != null) ...[
                const SizedBox(height: defaultSizing),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: FormBuilderTextField(
                        name: '-sumatoria',
                        enabled: false,
                        initialValue:
                            widget.transaccion?.sumatoria.toString() ??
                                0.toString(),
                        decoration: CustomInputs.noBorder(
                            label: AppLocalizations.of(context)!.sumatoriaTotal,
                            hint: AppLocalizations.of(context)!.sumatoriaTotal,
                            icon: Icons.playlist_add_check_circle_outlined),
                      ),
                    ),
                    const SizedBox(width: defaultSizing),
                    Expanded(
                      flex: 2,
                      child: FormBuilderTextField(
                        name: 'descuento',
                        enabled: (promocion != null || beneficio != null)
                            ? false
                            : true,
                        initialValue:
                            widget.transaccion?.descuento.toString() ??
                                0.toString(),
                        decoration: CustomInputs.form(
                            label: AppLocalizations.of(context)!.descuento,
                            hint: AppLocalizations.of(context)!.descuento,
                            icon: Icons.discount_rounded),
                        validator: FormBuilderValidators.required(
                            errorText:
                                AppLocalizations.of(context)!.campoObligatorio),
                      ),
                    ),
                    const SizedBox(width: defaultSizing),
                    Expanded(
                      child: FormBuilderCheckbox(
                        name: 'aplicarDescuento',
                        title: Text(
                            AppLocalizations.of(context)!.aplicarDescuento),
                        initialValue: widget.transaccion?.aplicarDescuento,
                        decoration: CustomInputs.noBorder(),
                        onChanged: (value) {
                          provider.aplicarDescuento(
                              widget.transaccion!.id,
                              value!,
                              double.parse(provider.formKey.currentState!
                                  .fields['descuento']!.value));
                        },
                      ),
                    ),
                    const SizedBox(width: defaultSizing),
                    Expanded(
                      flex: 3,
                      child: FormBuilderTextField(
                        name: '-total',
                        enabled: false,
                        initialValue: widget.transaccion?.total.toString() ??
                            0.toString(),
                        style: context.titleLarge,
                        decoration: CustomInputs.noBorder(
                            label: AppLocalizations.of(context)!.totalPagar,
                            hint: AppLocalizations.of(context)!.totalPagar,
                            icon: Icons.price_check_rounded),
                      ),
                    ),
                  ],
                ),
              ],
              if (widget.transaccion?.estado ?? true) ...[
                const SizedBox(height: defaultSizing),
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
                }),
              ]
            ],
          ),
        )),
        const SizedBox(height: defaultSizing),
        if (widget.transaccion != null) ...[
          _TransaccionDetallesIndex(widget.transaccion!)
        ]
      ],
    );
  }
}

class _TransaccionDetallesIndex extends StatelessWidget {
  final Transaccion transaccion;

  const _TransaccionDetallesIndex(this.transaccion);
  @override
  Widget build(BuildContext context) {
    // Para que la vista se actualice cada vez que se agregue un detalle
    Provider.of<TransaccionDetalleProvider>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IndexBody(
            title: AppLocalizations.of(context)!.detalles,
            columns: TransaccionDetalleDataSource.columns,
            actions: [
              EButton(
                text: AppLocalizations.of(context)!.accion('agregar'),
                icon: Icons.add_rounded,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child:
                            TransaccionDetalleModal(transaccion: transaccion),
                      );
                    },
                  );
                },
              )
            ],
            source: TransaccionDetalleDataSource(
                transaccion,
                transaccion.detalles ??
                    [
                      TransaccionDetalle(
                          id: AppLocalizations.of(context)!.items(0),
                          estado: false,
                          fechaCreacion: DateTime.now(),
                          nombre: AppLocalizations.of(context)!.items(0),
                          item: Item(
                              id: AppLocalizations.of(context)!.items(0),
                              estado: false,
                              fechaCreacion: DateTime.now(),
                              nombre: AppLocalizations.of(context)!.items(0)),
                          cantidad: 0,
                          valor: 0,
                          subtotal: 0)
                    ],
                context))
      ],
    );
  }
}
