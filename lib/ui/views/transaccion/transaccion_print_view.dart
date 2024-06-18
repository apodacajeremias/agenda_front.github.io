import 'package:agenda_front/services.dart';
import 'package:agenda_front/ui/widgets/pdf_view.dart';
import 'package:flutter/material.dart';

class TransaccionPrintView extends StatelessWidget {
  final String id;
  const TransaccionPrintView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return PDFScreen(
        url: '${ServerConnection.baseurl}/transacciones/$id/imprimir');
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Placeholder();
  // }
}
