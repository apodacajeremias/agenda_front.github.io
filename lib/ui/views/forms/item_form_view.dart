// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/models/entities/item.dart';
import 'package:agenda_front/models/enums/tipo_transaccion.dart';
import 'package:agenda_front/providers/item_provider.dart';
import 'package:agenda_front/ui/cards/white_card.dart';
import 'package:agenda_front/ui/inputs/custom_inputs.dart';
import 'package:agenda_front/ui/shared/forms/form_footer.dart';
import 'package:agenda_front/ui/shared/forms/form_header.dart';
import 'package:agenda_front/ui/shared/inputs/form_builder_currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ItemFormView extends StatelessWidget {
  final Item? item;
  const ItemFormView({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ItemProvider>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        children: [
          FormHeader(title: 'Item'),
          WhiteCard(
              child: FormBuilder(
                  key: provider.formKey,
                  child: Column(
                    children: [
                      if (item?.id != null) ...[
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: FormBuilderTextField(
                                  name: 'id',
                                  initialValue: item?.id,
                                  enabled: false,
                                  decoration: CustomInputs.form(
                                      label: 'ID',
                                      hint: 'ID',
                                      icon: Icons.qr_code),
                                )),
                            SizedBox(width: 10),
                            Expanded(
                                child: FormBuilderSwitch(
                                    name: 'activo',
                                    title: Text('Estado del registro'),
                                    initialValue: item?.activo)),
                          ],
                        )
                      ],
                      SizedBox(height: 10),
                      FormBuilderTextField(
                          name: 'nombre',
                          initialValue: item?.nombre,
                          enabled: item?.activo ?? true,
                          decoration: CustomInputs.form(
                              label: 'Nombre',
                              hint: 'Nombre descriptivo',
                              icon: Icons.info),
                          validator: FormBuilderValidators.required(
                              errorText: 'Campo obligatorio')),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          // Expanded(
                          //   child: FormBuilderTextField(
                          //       name: 'precio',
                          //       initialValue: item?.precio?.toString(),
                          //       enabled: item?.activo ?? true,
                          //       decoration: CustomInputs.form(
                          //           label: 'Precio',
                          //           hint: 'Precio del item',
                          //           icon: Icons.tag),
                          //       validator: FormBuilderValidators.min(1,
                          //           errorText: 'Ingrese un valor'),
                          //       inputFormatters: [CurrencyInputFormatter()]),
                          // ),
                          Expanded(
                              child: FormBuilderCurrency(
                                  name: 'precio',
                                  label: 'Precio',
                                  initialValue: item?.precio,
                                  enabled: item?.activo ?? true)),
                          SizedBox(width: 10),
                          Expanded(
                            child: FormBuilderDropdown(
                              name: 'tipo',
                              initialValue: item?.tipo,
                              enabled: item?.activo ?? true,
                              decoration: CustomInputs.form(
                                  label: 'Tipo',
                                  hint: 'Tipo de item',
                                  icon: Icons.info),
                              items: TipoTransaccion.values
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
                      ),
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
}
