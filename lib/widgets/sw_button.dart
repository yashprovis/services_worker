import 'package:flutter/material.dart';
import 'package:services_worker/widgets/sw_text.dart';

import '../constants.dart';

class SwButton extends StatelessWidget {
  final String text;
  final void Function() func;
  final double? width;
  final double? height;
  final double? textSize;
  final bool isLoading;
  final Color? color;
  final Color? textColor;
  const SwButton(
      {Key? key,
      required this.text,
      required this.func,
      this.height,
      this.width,
      this.textSize,
      required this.isLoading,
      this.color,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? () {} : func,
      child: Container(
          height: height ?? 52,
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: appGradient,
            borderRadius: BorderRadius.circular(5),
            //color: color ?? primaryColor,
          ),
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                      strokeWidth: 1.5, color: Colors.white),
                )
              : SwText(text, color: textColor ?? Colors.white, size: textSize)),
    );
  }
}
