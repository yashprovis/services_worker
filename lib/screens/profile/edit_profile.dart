import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/worker_provider.dart';
import '../../widgets/sheets/change_password.dart';
import '../../widgets/sheets/image_picker_sheet.dart';
import '../../widgets/sw_button.dart';
import '../../widgets/sw_text.dart';
import '../../widgets/sw_textfield.dart';

class EditProfile extends StatefulWidget {
  static const routeName = "/editProfile";
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> editProfileFormKey = GlobalKey();

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  FocusNode emailNode = FocusNode();
  FocusNode nameNode = FocusNode();
  FocusNode phoneNode = FocusNode();

  String? gender;

  @override
  void initState() {
    WorkerProvider workerProvider =
        Provider.of<WorkerProvider>(context, listen: false);
    gender = workerProvider.getWorker.gender;
    emailController.text = workerProvider.getWorker.email;
    nameController.text = workerProvider.getWorker.name;
    phoneController.text = workerProvider.getWorker.phone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WorkerProvider workerProvider = Provider.of<WorkerProvider>(context);
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
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 24,
                        //color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const SwText(
                      "Edit Profile",
                      // color: Colors.white,
                      size: 20,
                      //   weight: FontWeight.w500,
                    )
                  ],
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Form(
                      key: editProfileFormKey,
                      child: Column(children: [
                        GestureDetector(
                            onTap: () {
                              imagePickerSheet(context);
                            },
                            child: Container(
                              height: 120,
                              width: 120,
                              margin:
                                  const EdgeInsets.only(bottom: 40, top: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: primaryLight,
                                  borderRadius: BorderRadius.circular(60),
                                  image: workerProvider.getWorker.image == ""
                                      ? null
                                      : DecorationImage(
                                          image: NetworkImage(
                                              workerProvider.getWorker.image))),
                              child: workerProvider.getWorker.image == ""
                                  ? SwText(
                                      workerProvider.getWorker.name
                                          .substring(0, 2)
                                          .toUpperCase(),
                                      color: Colors.white,
                                      size: 26)
                                  : null,
                            )),
                        SwTextField(
                          controller: nameController,
                          hintText: "Name *".toUpperCase(),
                          isPassword: false,
                          action: TextInputAction.next,
                          node: nameNode,
                          nextNode: phoneNode,
                        ),
                        const SizedBox(height: 20),
                        SwTextField(
                          controller: phoneController,
                          hintText: "Phone Number *".toUpperCase(),
                          isPassword: false,
                          action: TextInputAction.next,
                          node: phoneNode,
                          nextNode: emailNode,
                        ),
                        const SizedBox(height: 20),
                        SwTextField(
                          controller: emailController,
                          hintText: "Email *".toUpperCase(),
                          isPassword: false,
                          node: emailNode,
                          type: TextInputType.emailAddress,
                        ),

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 16, left: 10, bottom: 6),
                            child: SwText("Select Gender",
                                color: primaryColor, weight: FontWeight.w500),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                                width: 140,
                                child: RadioListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  title: const SwText("Male", size: 16),
                                  value: "male",
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value.toString();
                                    });
                                  },
                                )),
                            SizedBox(
                                width: 140,
                                child: RadioListTile(
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                  title: const SwText("Female", size: 16),
                                  value: "female",
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value.toString();
                                    });
                                  },
                                )),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {
                                changePasswordSheet(context);
                              },
                              child: const SwText("Change Password",
                                  color: primaryColor,
                                  weight: FontWeight.bold,
                                  size: 14)),
                        ),
                        // Card(
                        //   elevation: 4,
                        //   child: SwButton(
                        //       text: "Change Password",
                        //       func: () {
                        //         changePasswordSheet(context);
                        //       },
                        //       color: Colors.white,
                        //       textColor: primaryColor,
                        //       isLoading: false),
                        // ),
                        //  const SizedBox(height: 16),
                        Card(
                            elevation: 4,
                            child: SwButton(
                                text: "Save Changes",
                                func: () {
                                  workerProvider.updateWorker(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      gender: gender,
                                      image: null,
                                      context: context);
                                },
                                isLoading: false))
                      ])))
            ])));
  }
}
