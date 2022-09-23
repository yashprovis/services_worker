import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:services_worker/providers/booking_provider.dart';
import 'package:services_worker/widgets/dialogs/reject_booking.dart';
import 'package:services_worker/widgets/sw_text.dart';
import '../../constants.dart';
import '../../helpers/methods.dart';
import '../../models/booking_model.dart';
import '../../services/booking_service.dart';
import '../../widgets/sw_button.dart';

class NoBooking extends StatefulWidget {
  final Booking? booking;
  const NoBooking({Key? key, required this.booking}) : super(key: key);

  @override
  State<NoBooking> createState() => _NoBookingState();
}

class _NoBookingState extends State<NoBooking> {
  String otpErrorText = "";
  String otp = "";
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    BookingProvider bookingProvider = Provider.of<BookingProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: GestureDetector(
        onTap: () {
          // Navigator.of(context).pushNamed(InvoicePreview.routeName,
          //     arguments: "SW000${index + 1}");
        },
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SwText("Id: ${widget.booking!.id}",
                        size: 14, color: primaryColor),
                    Row(
                      children: [
                        GestureDetector(
                            // onTap: () => downloadPdf(),
                            child: const Icon(Icons.timer_outlined, size: 22)),
                        const SizedBox(width: 4),
                        Text(
                            "${durationToString(widget.booking!.bookingDuration)} Hr."),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: SwText(
                      "Date: ${DateFormat("MMM dd,yy hh:mm a").format(widget.booking!.bookingDate)}",
                      size: 12,
                      color: Colors.grey),
                ),
                SwText("Customer: ${widget.booking!.customerName}", size: 14),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: SwText("Amount: ₹${widget.booking!.bookingTotal}",
                      size: 14),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 2),
                  child: SwText(
                      "Address: ${widget.booking!.address.toString()}",
                      size: 12,
                      color: Colors.grey[600]),
                ),
                const Divider(),
                Center(
                    child: SwText("Enter OTP from customer to start",
                        size: 14, color: Colors.grey[600])),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: SizedBox(
                    height: 50,
                    child: OtpTextField(
                      numberOfFields: 4,
                      borderColor: primaryColor,
                      focusedBorderColor: primaryColor,
                      margin: const EdgeInsets.only(right: 10),
                      borderRadius: BorderRadius.circular(10),
                      showFieldAsBox: true,
                      borderWidth: 2,
                      // enabled: widget.booking!.bookingDate
                      //             .difference(DateTime.now())
                      //             .inMinutes <=
                      //         60
                      //     ? true
                      //     : false,
                      onCodeChanged: (String code) {
                        otp = otp + code;
                        setState(() {});
                      },
                      textStyle: const TextStyle(
                          height: 1,
                          fontSize: 18,
                          color: primaryColor,
                          fontWeight: FontWeight.w500),
                      onSubmit: (String verificationCode) {},
                    ),
                  ),
                ),
                if (otpErrorText.isNotEmpty)
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      otpErrorText,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                SizedBox(height: 10),
                SwButton(
                    text: "Start Booking",
                    func: () async {
                      if (otp.length != 4) {
                        otpErrorText = "*Please enter OTP to start the booking";
                        setState(() {});
                        return;
                      } else if (otp != widget.booking!.bookingOtp) {
                        otpErrorText =
                            "*Incorrect OTP. Please enter correct OTP to start";
                        setState(() {});
                        return;
                      }
                      otpErrorText = "";
                      isLoading = true;
                      setState(() {});
                      var bookingData = await BookingService().updateBooking(
                          widget.booking!.id,
                          "started",
                          widget.booking!.workerId,
                          widget.booking!.customerId,
                          bookingProvider.socket);
                      if (bookingData != null) {
                        bookingProvider.setBooking(bookingData);
                        bookingProvider.startBooking();
                      }
                    },
                    height: 40,
                    isLoading: isLoading),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Contact",
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 4),
                        child: GestureDetector(
                          onTap: () async {
                            rejectDialog(context, widget.booking!, "current");
                          },
                          child: const Text(
                            "Reject",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
