import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:services_worker/services/booking_service.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/booking_model.dart';
import '../providers/booking_provider.dart';
import '../providers/worker_provider.dart';
import '../widgets/sw_scaffold.dart';
import '../widgets/sw_text.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  init() async {
    WorkerProvider workerProvider =
        Provider.of<WorkerProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(tokenPref) ?? "";
    if (token.isNotEmpty) {
      setState(() {
        headerApiMap["x-access-token"] = token;
      });
      await workerProvider.refreshWorker();
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BookingProvider bookingProvider = Provider.of<BookingProvider>(context);
    return SwScaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            height: 120,
            child: Hero(
                tag: "logo-shift",
                child: Image.asset("assets/images/logo.png"))),
        GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(24),
            itemCount: homeItems.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(
                    homeItems[index]["route"],
                  )
                      .whenComplete(() {
                    if (index == 0) {
                      bookingProvider.setBooking(null);
                      bookingProvider.resetBooking();
                    }
                  });
                },
                child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: index == 0 ? primaryColor : Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            homeItems[index]["icon"],
                            size: 28,
                            color: index != 0 ? null : Colors.white,
                          ),
                        ),
                        SwText(
                          homeItems[index]["name"],
                          size: 20,
                          align: TextAlign.center,
                          color: index != 0 ? null : Colors.white,
                        ),
                        // if (index == 0)
                        //   Padding(
                        //     padding: const EdgeInsets.all(6),
                        //     child: SwText(
                        //         "Next: ${nextBooking == null ? "-" : DateFormat("MMM dd,yy hh:mm a").format(nextBooking!.bookingDate)}",
                        //         size: 12,
                        //         align: TextAlign.center,
                        //         color: Colors.grey[600]),
                        //   )
                      ],
                    )),
              );
            }),
      ],
    ));
  }
}
