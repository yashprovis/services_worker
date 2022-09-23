import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:services_worker/providers/booking_provider.dart';
import 'package:services_worker/widgets/sw_button.dart';
import 'package:services_worker/widgets/sw_text.dart';

import '../../models/booking_model.dart';
import '../../services/booking_service.dart';

class WaitingForPayment extends StatefulWidget {
  final Booking booking;
  const WaitingForPayment({super.key, required this.booking});

  @override
  State<WaitingForPayment> createState() => _WaitingForPaymentState();
}

class _WaitingForPaymentState extends State<WaitingForPayment> {
  @override
  Widget build(BuildContext context) {
    BookingProvider bookingProvider = Provider.of<BookingProvider>(context);

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(height: 40),
        CircularProgressIndicator(
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
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
                text: "Collect Cash",
                color: Colors.white70,
                textColor: Colors.black,
                func: () async {
                  var bookingData = await BookingService().updateBooking(
                      widget.booking.id,
                      "completed",
                      widget.booking.workerId,
                      widget.booking.customerId,
                      bookingProvider.socket);
                  if (bookingData != null) {
                    bookingProvider.setBooking(bookingData);
                    bookingProvider.completeBooking();
                  }
                },
                isLoading: false))
      ]),
    );
  }
}
