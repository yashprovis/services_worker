import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:services_worker/providers/booking_provider.dart';
import 'package:services_worker/widgets/booking/booking_session.dart';
import 'package:services_worker/widgets/sw_text.dart';

import '../../widgets/booking/no_booking.dart';

class BookingScreen extends StatefulWidget {
  static const routeName = "/booking";
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    BookingProvider bookingProvider = Provider.of<BookingProvider>(context);
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
                      "${bookingProvider.getBookingStatus == 0 ? "Next " : ""}Booking",
                      // color: Colors.white,
                      size: 20,
                      //   weight: FontWeight.w500,
                    )
                  ],
                ),
              ),
              AnimatedContainer(
                  duration: Duration(seconds: 1),
                  child: bookingProvider.getBookingStatus == 0
                      ? NoBooking()
                      : BookingSession())
            ])));
  }
}
