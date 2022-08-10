import 'package:flutter/material.dart';

import '../constants.dart';
import '../widgets/sw_button.dart';
import '../widgets/sw_text.dart';
import '../widgets/sw_textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = "/forgot-password";
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  GlobalKey<FormState> forgotPassFormKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: primaryLight,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              padding: const EdgeInsets.only(bottom: 20, top: 30),
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SizedBox(
                              height: 120,
                              child: (Hero(
                                  tag: "logo-shift",
                                  child:
                                      Image.asset("assets/images/logo.png")))),
                          const SizedBox(height: 10),
                          const SwText(
                            "FORGOT PASSWORD",
                            color: Colors.white,
                            size: 20,
                            weight: FontWeight.w300,
                          )
                        ],
                      )),
                  Positioned(
                      left: 20,
                      top: 20,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 24,
                          color: Colors.white,
                        ),
                      ))
                ],
              ),
            ),
            // ListView(
            //   shrinkWrap: true,
            //   padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            //   children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Form(
                key: forgotPassFormKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: SwText(
                          "Please provide your account email address to receive an email to reset your password.",
                          weight: FontWeight.w300,
                          size: 14),
                    ),
                    const SizedBox(height: 20),
                    SwTextField(
                      controller: emailController,
                      hintText: "Email *",
                      isPassword: false,
                      type: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    SwButton(
                        isLoading: isLoading,
                        text: "SUBMIT",
                        func: () {
                          // if (forgotPassFormKey.currentState!.validate()) {
                          //   setState(() {
                          //     isLoading = true;
                          //   });
                          //   try {
                          //     UserService()
                          //         .forgotPassEmail(
                          //             email: emailController.text,
                          //             context: context)
                          //         .whenComplete(() => setState(() {
                          //               isLoading = false;
                          //             }));
                          //   } catch (e) {}
                          // }
                        }),
                  ],
                ),
              ),
            )
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
