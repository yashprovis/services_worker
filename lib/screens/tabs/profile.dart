import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:services_worker/providers/worker_provider.dart';
import 'package:services_worker/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../widgets/sw_text.dart';
import '../profile/edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = "/profile";
  const ProfileScreen({Key? key}) : super(key: key);

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
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 24,
                        //color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 16),
                    SwText(
                      "Profile",
                      // color: Colors.white,
                      size: 20,
                      //   weight: FontWeight.w500,
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushNamed(EditProfile.routeName),
                child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 25),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: SwText(
                              workerProvider.getWorker.name
                                  .substring(0, 2)
                                  .toUpperCase(),
                              color: Colors.white,
                              size: 20),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 110,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SwText(workerProvider.getWorker.name,
                                      size: 18),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child:
                                        Icon(Icons.arrow_forward_ios_rounded),
                                  )
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: SwText(workerProvider.getWorker.email,
                                    size: 13),
                              ),
                              SwText(workerProvider.getWorker.phone, size: 13)
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: profileItems.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () async {
                      if (index == 3) {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString(tokenPref, "").then((value) =>
                            Navigator.of(context)
                                .pushReplacementNamed(LoginScreen.routeName));
                      } else {
                        Navigator.of(context)
                            .pushNamed(profileItems[index]["route"]);
                      }
                    },
                    minLeadingWidth: 30,
                    leading: Icon(profileItems[index]["icon"], size: 30),
                    title: SwText(profileItems[index]["name"]),
                    trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  );
                },
              )
            ])));
  }
}
