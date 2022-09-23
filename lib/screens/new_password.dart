import 'package:flutter/material.dart';

import '../constants.dart';
import '../helpers/methods.dart';

import '../services/worker_service.dart';
import '../widgets/sw_button.dart';
import '../widgets/sw_text.dart';
import '../widgets/sw_textfield.dart';

class NewPasswordScreen extends StatefulWidget {
  static const routeName = "/newPassword";
  final String email;
  const NewPasswordScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  GlobalKey<FormState> forgotPassFormKey = GlobalKey();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: primaryLight,
                  borderRadius: BorderRadius.only(
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
                            "RESET PASSWORD",
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
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 24,
                          color: Colors.white,
                        ),
                      ))
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Form(
                key: forgotPassFormKey,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: SwText(
                          "Enter new password to reset your password.",
                          weight: FontWeight.w300,
                          size: 14),
                    ),
                    const SizedBox(height: 20),
                    SwTextField(
                      controller: passController,
                      hintText: "New Password ",
                      isPassword: true,
                      //type: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    SwTextField(
                      controller: confirmPassController,
                      hintText: "Confirm Password ",
                      isPassword: true,
                      //type: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    SwButton(
                        isLoading: isLoading,
                        text: "Reset Password",
                        func: () async {
                          if (forgotPassFormKey.currentState!.validate()) {
                            if (passController.text.trim() ==
                                confirmPassController.text.trim()) {
                              setState(() {
                                isLoading = true;
                              });
                              FocusScope.of(context).unfocus();
                              var data = await WorkerService().forgotPassword(
                                  email: widget.email,
                                  newPassword: passController.text.trim());
                              if (data != null && data is Map) {
                                showSnack(
                                    context: context,
                                    message: "Password Reset successful.",
                                    color: Colors.green);
                                await WorkerService().loginWorker(
                                    email: widget.email,
                                    password: passController.text.trim(),
                                    context: context);
                              } else if (data != null && data is String) {
                                showSnack(
                                    context: context,
                                    message: data,
                                    color: Colors.red);
                              } else {
                                showSnack(
                                    context: context,
                                    message: "Request Failed. Try again later.",
                                    color: Colors.red);
                              }
                              if (mounted) {
                                isLoading = false;
                                setState(() {});
                              }
                            } else {
                              showSnack(
                                  context: context,
                                  message: "Passwords don't match.",
                                  color: Colors.red);
                            }
                          }
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
