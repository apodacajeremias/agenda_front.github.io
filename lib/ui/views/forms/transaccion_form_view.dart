import 'package:agenda_front/constants.dart';
import 'package:agenda_front/models/entities/grupo.dart';
import 'package:agenda_front/models/entities/persona.dart';
import 'package:agenda_front/models/entities/transaccion.dart';
import 'package:agenda_front/models/enums/prioridad.dart';
import 'package:agenda_front/models/enums/situacion.dart';
import 'package:agenda_front/providers/transaccion_provider.dart';
import 'package:agenda_front/ui/dropdown/colaborador_dropdown.dart';
import 'package:agenda_front/ui/dropdown/persona_dropdown.dart';
import 'package:agenda_front/ui/shared/forms/form_footer.dart';
import 'package:agenda_front/ui/shared/forms/form_header.dart';
import 'package:agenda_front/utils/fecha_util.dart';
import 'package:agenda_front/ui/cards/white_card.dart';
import 'package:agenda_front/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransaccionFormView extends StatelessWidget {
  final Transaccion? transaccion;
  const TransaccionFormView({super.key, this.transaccion});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransaccionProvider>(context, listen: false);
    return SizedBox(
      height: double.maxFinite,
      width: double.maxFinite,
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const FormHeader(title: 'Transacción'),
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

class TransaccionFormDialog extends StatelessWidget {
  final Persona? persona;
  const TransaccionFormDialog({super.key, this.persona});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransaccionProvider>(context, listen: false);
    return SizedBox(
      height: double.maxFinite,
      width: double.maxFinite,
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const FormHeader(title: 'Transaccionr'),
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

FormBuilder _form(TransaccionProvider provider, {Persona? persona}) {
  List<Grupo>? grupos;
  return FormBuilder(
    key: provider.formKey,
    child: const Column(),
  );
}
