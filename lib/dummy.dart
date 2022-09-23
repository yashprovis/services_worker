import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;
import 'package:services_worker/constants.dart';

// void printPdf() async {
//   http.Response response = await http
//       .get(Uri.parse('http://www.africau.edu/images/default/sample.pdf'));
//   var pdfData = response.bodyBytes;
//   await Printing.layoutPdf(onLayout: (format) async => pdfData);
// }

void sharePdf(String invoice) async {
  http.Response response = await http.get(Uri.parse("$uploadUrl/$invoice"));
  var pdfData = response.bodyBytes;
  await Printing.sharePdf(
      bytes: pdfData, filename: invoice.replaceAll("invoices/", ""));
}

void downloadPdf(String invoice) async {
  http.Response response = await http.get(Uri.parse("$uploadUrl/$invoice"));
  var pdfData = response.bodyBytes;

  final output = await getApplicationDocumentsDirectory();
  final file = File('${output.path}${invoice.replaceAll("invoices/", "")}');
  await file.writeAsBytes(pdfData);
  await OpenFile.open(file.path);
}
