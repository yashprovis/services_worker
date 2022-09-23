import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:provider/provider.dart';
import 'package:services_worker/constants.dart';
import 'package:services_worker/providers/booking_provider.dart';
import 'package:services_worker/widgets/booking/booking_done.dart';
import 'package:services_worker/widgets/booking/booking_session.dart';
import 'package:services_worker/widgets/sw_text.dart';

import '../../models/booking_model.dart';
import '../../services/booking_service.dart';
import '../../widgets/booking/no_booking.dart';
import '../../widgets/booking/waiting_for_payment.dart';

class BookingScreen extends StatefulWidget {
  static const routeName = "/booking";
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  Booking? nextBooking;
  io.Socket? socket;
  bool isLoading = true;
  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    if (socket != null) {
      socket!.disconnect();
      socket!.dispose();
    }
    super.dispose();
  }

  init() async {
    BookingProvider bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);
    nextBooking = await BookingService().fetchLatestBooking();
    if (nextBooking != null) {
      bookingProvider.socket = connectSocket(nextBooking!.id);
      bookingProvider.setBooking(nextBooking);
      bookingProvider.bookingStatus = nextBooking!.bookingStatus;
    }
    isLoading = false;
    setState(() {});
  }

  io.Socket? connectSocket(bookingId) {
    socket = io.io(
        'http://192.168.100.43:5000',
        io.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setExtraHeaders({"bookingid": bookingId})
            .build());
    socket!.connect();
    socket!.on("receive-update-booking", (data) => subscribeSocket(data));
    return socket;
  }

  subscribeSocket(dynamic data) async {
    print(data);
    BookingProvider bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);
    if (data["bookingStatus"] != "completed") {
      bookingProvider.bookingStatus = (data["bookingStatus"]);
      nextBooking = await BookingService().fetchLatestBooking();
      bookingProvider.setBooking(nextBooking);
      bookingProvider.bookingStatus = nextBooking!.bookingStatus;
    } else {
      bookingProvider.completeBooking();
    }
  }

  @override
  Widget build(BuildContext context) {
    BookingProvider bookingProvider = Provider.of<BookingProvider>(context);
    return Scaffold(
        backgroundColor: bookingProvider.getBookingStatus == "completed"
            ? Colors.greenAccent[700]
            : bookingProvider.getBookingStatus == "requested"
                ? primaryLight
                : Colors.white,
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
                        color: bookingProvider.getBookingStatus ==
                                    "completed" ||
                                bookingProvider.getBookingStatus == "requested"
                            ? Colors.white
                            : null,
                        //color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 16),
                    SwText(
                      "${bookingProvider.getBookingStatus == "created" ? "Next " : ""}Booking",
                      color: bookingProvider.getBookingStatus == "completed" ||
                              bookingProvider.getBookingStatus == "requested"
                          ? Colors.white
                          : null,
                      size: 20,
                      //   weight: FontWeight.w500,
                    )
                  ],
                ),
              ),
              isLoading
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height - 200,
                      child: const Center(child: CircularProgressIndicator()))
                  : bookingProvider.getBooking == null
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height - 200,
                          child: const Center(
                            child: SwText("No upcoming bookings."),
                          ),
                        )
                      : AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          child: bookingProvider.getBookingStatus == "created"
                              ? NoBooking(booking: nextBooking)
                              : bookingProvider.getBookingStatus == "started"
                                  ? BookingSession(booking: nextBooking)
                                  : bookingProvider.getBookingStatus ==
                                          "requested"
                                      ? WaitingForPayment(booking: nextBooking!)
                                      : BookingDone(
                                          booking: nextBooking!,
                                        ))
            ])));
  }
}
