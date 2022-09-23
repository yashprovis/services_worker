import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:services_worker/constants.dart';

import '../../helpers/methods.dart';
import '../../services/worker_service.dart';
import '../sw_button.dart';
import '../sw_text.dart';
import '../sw_textfield.dart';

void changePasswordSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (builder) {
        return const ChangePasswordSheet();
      });
}

class ChangePasswordSheet extends StatefulWidget {
  const ChangePasswordSheet({Key? key}) : super(key: key);

  @override
  State<ChangePasswordSheet> createState() => _ChangePasswordSheetState();
}

class _ChangePasswordSheetState extends State<ChangePasswordSheet> {
  bool isLoading = false;
  String? resultString;
  GlobalKey<FormState> changePassFormKey = GlobalKey();
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();

  FocusNode oldPassNode = FocusNode();
  FocusNode newPassNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    //  UserProvider userProvider = Provider.of<UserProvider>(context);
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: AnimatedContainer(
          duration: Duration(milliseconds: 400),
          padding: EdgeInsets.all(15),
          height: 330,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0))),
          child: Form(
            key: changePassFormKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SwText(
                      "Change Password",
                      size: 18,
                      color: primaryColor,
                      weight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(Icons.close))
                ],
              ),
              SizedBox(height: 20),
              SwTextField(
                controller: oldPassController,
                hintText: "Old Password *".toUpperCase(),
                isPassword: true,
                action: TextInputAction.next,
                node: oldPassNode,
                func: (v) {
                  setState(() {
                    resultString = null;
                  });
                },
                nextNode: newPassNode,
              ),
              const SizedBox(height: 20),
              SwTextField(
                controller: newPassController,
                hintText: "New Password *".toUpperCase(),
                isPassword: true,
                node: newPassNode,
                func: (v) {
                  setState(() {
                    resultString = null;
                  });
                },
              ),
              SizedBox(height: 20),
              SwButton(
                  height: 44,
                  isLoading: isLoading,
                  text: "Update Password",
                  textSize: 16,
                  func: () async {
                    if (changePassFormKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      FocusScope.of(context).unfocus();
                      var data = await WorkerService().resetPassword(
                          oldPassword: oldPassController.text.trim(),
                          newPassword: newPassController.text.trim());
                      if (data != null && data is Map) {
                        showSnack(
                            context: context,
                            message: "Password Reset successful.",
                            color: Colors.green);
                        Navigator.of(context).pop();
                      } else if (data != null && data is String) {
                        resultString = data;
                      } else {
                        resultString = "Request Failed. Try again later.";
                      }
                      if (mounted) {
                        isLoading = false;
                        setState(() {});
                      }
                    }
                  }),
              SizedBox(height: resultString == null ? 0 : 12),
              resultString == null
                  ? SizedBox()
                  : Center(
                      child: SwText(
                        "*$resultString",
                        color: Colors.red,
                        size: 16,
                      ),
                    )
            ]),
          )),
    );
  }
}
