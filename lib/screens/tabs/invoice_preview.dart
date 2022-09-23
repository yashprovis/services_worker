import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:printing/printing.dart';
import 'package:services_worker/constants.dart';
import 'package:services_worker/widgets/sw_text.dart';

class InvoicePreview extends StatefulWidget {
  static const routeName = "/invoicePrview";
  final Map args;
  const InvoicePreview({Key? key, required this.args}) : super(key: key);

  @override
  State<InvoicePreview> createState() => _InvoicePreviewState();
}

class _InvoicePreviewState extends State<InvoicePreview> {
  Uint8List? pdfBytes;
  @override
  void initState() {
    http.get(Uri.parse("$uploadUrl/${widget.args["invoice"]}")).then((value) {
      setState(() {
        pdfBytes = value.bodyBytes;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: SwText(widget.args['id'], color: Colors.white)),
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
