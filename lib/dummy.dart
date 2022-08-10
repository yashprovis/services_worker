import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;

void printPdf() async {
  http.Response response = await http
      .get(Uri.parse('http://www.africau.edu/images/default/sample.pdf'));
  var pdfData = response.bodyBytes;
  await Printing.layoutPdf(onLayout: (format) async => pdfData);
  // final document = await PdfDocument.openData(InternetFile.get(
  //     'https://swayamkiosk.s3.amazonaws.com/nehavijayjaiswal882022120810pm.pdf'));
  // final page = await document.getPage(1);
  // final pageImage = await page.render(width: page.width, height: page.height);
  // await page.close();
}

void sharePdf() async {
  http.Response response = await http
      .get(Uri.parse('http://www.africau.edu/images/default/sample.pdf'));
  var pdfData = response.bodyBytes;
  await Printing.sharePdf(bytes: pdfData, filename: 'anyname.pdf');
}

void downloadPdf() async {
  http.Response response = await http
      .get(Uri.parse('http://www.africau.edu/images/default/sample.pdf'));
  var pdfData = response.bodyBytes;

  final output = await getApplicationDocumentsDirectory();
  final file = File('${output.path}/anyname.pdf');
  await file.writeAsBytes(pdfData);
  await OpenFile.open(file.path);
}
