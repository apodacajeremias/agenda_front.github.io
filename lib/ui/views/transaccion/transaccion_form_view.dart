import 'package:agenda_front/providers.dart';
import 'package:agenda_front/src/models/entities/grupo.dart';
import 'package:agenda_front/src/models/entities/persona.dart';
import 'package:agenda_front/src/models/entities/transaccion.dart';
import 'package:agenda_front/ui/widgets/form_footer.dart';
import 'package:agenda_front/ui/widgets/form_header.dart';
import 'package:agenda_front/ui/widgets/white_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
