import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../widgets/sw_text.dart';

showSnack(
    {required BuildContext context,
    required String message,
    Color? color,
    double? margin}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(bottom: margin ?? 30, left: 20, right: 20),
    content: SwText(
      message,
      size: 14,
      color: Colors.white,
    ),
    backgroundColor: color ?? Color(0xFF080808),
  ));
}

Future getImageFromCamera() async {
  var image = await ImagePicker().pickImage(source: ImageSource.camera);
  return image;
}

Future getImageFromGallery() async {
  var image = await ImagePicker().pickImage(source: ImageSource.gallery);
  return image;
}

String formatNumber(num value) {
  var formatter = NumberFormat('#,##,000');
  return formatter.format(value);
}

String durationToString(int minutes) {
  var d = Duration(minutes: minutes);
  List<String> parts = d.toString().split(':');
  return '${parts[0].padLeft(2)}.${parts[1].padLeft(2, '0')}';
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase().replaceAll("*", '')}";
  }
}
