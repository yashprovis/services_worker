import 'package:flutter/material.dart';

import '../../constants.dart';
import '../sw_text.dart';

class DropdownContainer extends StatelessWidget {
  final String title;
  const DropdownContainer({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 48,
      decoration: BoxDecoration(
          border: Border.all(color: primaryColor, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SwText(title),
            Icon(Icons.arrow_drop_down, color: primaryColor)
          ],
        ),
      ),
    );
  }
}
