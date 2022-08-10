import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../widgets/sw_scaffold.dart';
import '../widgets/sw_text.dart';
import 'tabs/booking.dart';
import 'tabs/booking_history.dart';
import 'tabs/invoice.dart';
import 'tabs/profile.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List homeItems = [
    {
      "name": "Booking",
      "route": BookingScreen.routeName,
      "icon": CupertinoIcons.cube_box
    },
    {
      "name": "Booking History",
      "route": BookingHistoryScreen.routeName,
      "icon": CupertinoIcons.arrow_counterclockwise_circle
    },
    {
      "name": "My Profile",
      "route": ProfileScreen.routeName,
      "icon": CupertinoIcons.person
    },
    {
      "name": "Invoices",
      "route": InvoiceScreen.routeName,
      "icon": CupertinoIcons.doc_chart
    }
  ];

  // @override
  // void initState() {
  //   init();
  //   super.initState();
  // }

  // init() async {
  //   UserProvider userProvider =
  //       Provider.of<UserProvider>(context, listen: false);
  //   OrderProvider orderProvider =
  //       Provider.of<OrderProvider>(context, listen: false);
  //   await userProvider.refreshUser();
  //   await orderProvider.fetchCurrentOrders();
  // }

  @override
  Widget build(BuildContext context) {
    //  TabsProvider tabs = Provider.of<TabsProvider>(context);
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
                  Navigator.of(context).pushNamed(homeItems[index]["route"]);
                },
                child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(homeItems[index]["icon"], size: 28),
                        ),
                        SwText(homeItems[index]["name"],
                            size: 20, align: TextAlign.center),
                        if (index == 0)
                          Padding(
                            padding: const EdgeInsets.all(6),
                            child: SwText(
                                "Next: ${DateFormat("MMM dd,yy hh:mm a").format(DateTime.now())}",
                                size: 12,
                                align: TextAlign.center,
                                color: Colors.grey[600]),
                          )
                      ],
                    )),
              );
            }),
      ],
    ));
  }
}
