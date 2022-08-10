import 'package:flutter/material.dart';
import 'package:services_worker/constants.dart';

class SwScaffold extends StatelessWidget {
  final Widget body;
  const SwScaffold({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(gradient: appGradient),
        child: body,
      ),
    );
  }
}
