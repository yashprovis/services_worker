import 'package:flutter/material.dart';

import '../constants.dart';

class SwTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final FocusNode? node;
  final FocusNode? nextNode;
  final TextInputType? type;
  final TextInputAction? action;
  final bool? isEnabled;
  final Widget? suffixIcon;
  final void Function()? onSubmit;
  final void Function(String?)? func;

  const SwTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.isPassword,
      this.node,
      this.func,
      this.nextNode,
      this.type,
      this.action,
      this.isEnabled,
      this.suffixIcon,
      this.onSubmit})
      : super(key: key);

  @override
  State<SwTextField> createState() => _SwTextFieldState();
}

class _SwTextFieldState extends State<SwTextField> {
  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        onEditingComplete: widget.onSubmit,
        controller: widget.controller,
        focusNode: widget.node,
        autovalidateMode: widget.suffixIcon == null
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '*${widget.hintText}is Required';
          }
          if (value.length < 8 && widget.isPassword) {
            return '*${widget.hintText}is too Short';
          }
        },
        onFieldSubmitted: (_) {
          if (widget.nextNode != null) {
            FocusScope.of(context).requestFocus(widget.nextNode);
          } else {
            FocusScope.of(context).unfocus();
          }
        },
        cursorColor: primaryColor,
        cursorWidth: 1.5,
        cursorHeight: 16,
        obscureText: widget.isPassword && isHidden,
        enabled: widget.isEnabled ?? true,
        textInputAction: widget.action,
        keyboardType: widget.type,
        style: const TextStyle(fontSize: 14, height: 1),
        decoration: InputDecoration(
            // fillColor: Colors.white70,
            // filled: true,
            isDense: true,
            suffixIcon: widget.isPassword
                ? GestureDetector(
                    onTap: () {
                      isHidden = !isHidden;
                      setState(() {});
                    },
                    child: Icon(
                        isHidden ? Icons.visibility_off : Icons.visibility,
                        color: primaryColor),
                  )
                : widget.suffixIcon,
            hintText: widget.hintText,
            hintStyle: const TextStyle(
                fontSize: 14,
                height: 1,
                //   fontWeight: FontWeight.w500,
                color: primaryColor),
            errorBorder: errorBorder,
            focusedBorder: border,
            enabledBorder: border,
            focusedErrorBorder: errorBorder,
            border: border),
      ),
    );
  }
}
