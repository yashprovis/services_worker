import 'package:flutter/material.dart';

import '../../widgets/sw_text.dart';

class TermsConditions extends StatelessWidget {
  static const routeName = "/termsConditions";
  const TermsConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.only(top: 56),
            child: ListView(padding: EdgeInsets.zero, children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 24,
                        //color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 16),
                    SwText(
                      "Terms and Conditions",
                      // color: Colors.white,
                      size: 20,
                      //   weight: FontWeight.w500,
                    )
                  ],
                ),
              ),
            ])));
  }
}
