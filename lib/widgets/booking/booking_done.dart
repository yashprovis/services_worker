import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:services_worker/providers/booking_provider.dart';
import 'package:services_worker/widgets/sw_button.dart';
import 'package:services_worker/widgets/sw_text.dart';

import '../../models/booking_model.dart';
import '../../services/booking_service.dart';

class BookingDone extends StatefulWidget {
  final Booking booking;
  const BookingDone({super.key, required this.booking});

  @override
  State<BookingDone> createState() => _BookingDoneState();
}

class _BookingDoneState extends State<BookingDone> {
  @override
  Widget build(BuildContext context) {
    BookingProvider bookingProvider = Provider.of<BookingProvider>(context);

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(height: 40),
        //  CircularProgressIndicator(),
        const Icon(
          Icons.done_all,
          size: 60,
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: SwText(
            "Booking Id: ${widget.booking.id}\n\nWaiting for Payment ₹${bookingProvider.getBooking!.bookingTotal} from ${widget.booking.customerName}",
            align: TextAlign.center,
            color: Colors.white,
            height: 1.5,
            size: 18,
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 120),
            child: SwButton(
                text: "Back To Home",
                color: Colors.white,
                textColor: Colors.black,
                func: () {
                  Navigator.of(context).pop();
                },
                isLoading: false))
      ]),
    );
  }
}
