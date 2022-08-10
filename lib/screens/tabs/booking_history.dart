import 'package:flutter/material.dart';
import 'package:services_worker/constants.dart';
import 'package:services_worker/widgets/tabs/upcoming_tab.dart';

import '../../widgets/tabs/completed_tab.dart';
import '../../widgets/sw_text.dart';

class BookingHistoryScreen extends StatelessWidget {
  static const routeName = "/booking-history";
  const BookingHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            body: Padding(
          padding: const EdgeInsets.only(top: 56, left: 16, right: 16),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 16),
                  SwText(
                    "Booking History",
                    size: 20,
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: SizedBox(
                  height: 50,
                  child: TabBar(
                    labelColor: primaryColor,
                    tabs: [
                      Tab(
                        text: "Upcoming",
                      ),
                      Tab(
                        text: "Completed",
                      ),
                    ],
                  ),
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    UpcomingBookingTab(),
                    CompletedBookingTab(),
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}
