import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../models/booking_model.dart';
import '../../services/booking_service.dart';

import '../../widgets/sw_text.dart';
import '../../widgets/tabs/completed_tab.dart';
import '../../widgets/tabs/upcoming_tab.dart';

class BookingHistoryScreen extends StatefulWidget {
  static const routeName = "/bookingHistory";
  const BookingHistoryScreen({Key? key}) : super(key: key);

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  List<Booking>? allBooking;
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    allBooking = await BookingService().fetchAllWorkerBookings();
    setState(() {});
  }

  changeBooking() {
    allBooking = null;
    setState(() {});
    init();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            body: Padding(
          padding: const EdgeInsets.only(top: 48, left: 12, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 8, top: 10, bottom: 10),
                  child: Row(
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
                  )),
              const SizedBox(
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

              // create widgets for each tab bar here
              allBooking == null
                  ? SizedBox()
                  : Expanded(
                      child: TabBarView(
                        children: [
                          // first tab bar view widget
                          UpcomingBookingTab(
                            bookingList: allBooking ?? [],
                            func: changeBooking,
                          ),

                          // second tab bar viiew widget
                          CompletedBookingTab(bookingList: allBooking ?? [])
                        ],
                      ),
                    ),
            ],
          ),
        )));
  }
}
