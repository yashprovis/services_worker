import 'package:flutter/material.dart';

class SwText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? weight;
  final Color? color;
  final TextAlign? align;
  final int? maxLines;
  final double? height;
  const SwText(this.text,
      {Key? key,
      this.size,
      this.weight,
      this.color,
      this.align,
      this.maxLines,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
          letterSpacing: 1.3,
          height: height ?? 1,
          color: color ?? Colors.black,
          fontWeight: weight ?? FontWeight.w400,
          fontSize: size ?? 16),
    );
  }
}
