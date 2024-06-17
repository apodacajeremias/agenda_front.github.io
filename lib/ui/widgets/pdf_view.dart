import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';

class PDFScreen extends StatefulWidget {
  final String url;
  const PDFScreen({super.key, required this.url});

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

// String url = 'assets/pdf/instructions.pdf';

class _PDFScreenState extends State<PDFScreen> {
  late final _pdfController;

  // Future loadPdf() async {
  //   try {
  //     await rootBundle.load(url);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // loadPdf();
    _pdfController = PdfController(
      document: PdfDocument.openData(InternetFile.get(widget.url)),
    );
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget loaderWidget = const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      ),
    );
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.grey,
        height: MediaQuery.of(context).size.height,
        child: _pdfController == null
            ? loaderWidget
            : PdfView(controller: _pdfController),
      )),
    );
  }
}
