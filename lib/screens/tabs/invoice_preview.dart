import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:printing/printing.dart';
import 'package:services_worker/widgets/sw_text.dart';

class InvoicePreview extends StatefulWidget {
  static const routeName = "/invoicePrview";
  final String link;
  const InvoicePreview({Key? key, required this.link}) : super(key: key);

  @override
  State<InvoicePreview> createState() => _InvoicePreviewState();
}

class _InvoicePreviewState extends State<InvoicePreview> {
  Uint8List? pdfBytes;
  @override
  void initState() {
    http
        .get(Uri.parse('http://www.africau.edu/images/default/sample.pdf'))
        .then((value) {
      setState(() {
        pdfBytes = value.bodyBytes;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: SwText(widget.link, color: Colors.white)),
      body: pdfBytes == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : PdfPreview(
              build: (format) => pdfBytes!,
            ),
    );
  }
}
