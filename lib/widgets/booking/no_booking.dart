import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:services_worker/providers/booking_provider.dart';
import 'package:services_worker/widgets/sw_text.dart';
import '../../constants.dart';
import '../../widgets/sw_button.dart';

class NoBooking extends StatelessWidget {
  const NoBooking({Key? key}) : super(key: key);

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
                    const SwText("Booking No: SW000${0 + 1}",
                        size: 14, color: primaryColor),
                    Row(
                      children: [
                        GestureDetector(
                            // onTap: () => downloadPdf(),
                            child: const Icon(Icons.timer_outlined, size: 22)),
                        const SizedBox(width: 6),
                        const Text(
                            //   onTap: () => sharePdf(),
                            "1.5 hrs"),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: SwText(
                      "Date: ${DateFormat("MMM dd,yy hh:mm a").format(DateTime.now().add(const Duration(minutes: (0 + 1) * 2000)))}",
                      size: 12,
                      color: Colors.grey),
                ),
                const SwText("Customer: Ravi Provis", size: 14),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: const SwText("Amount: ₹4,000.00", size: 14),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 2),
                  child: SwText(
                      "Address: 503, Signature Tower, Tonk Phatak, Jaipur - 302006",
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
                      onCodeChanged: (String code) {
                        //handle validation or checks here if necessary
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
                // SizedBox(height: 10),
                SwButton(
                    text: "Start Booking",
                    func: () {
                      bookingProvider.startBooking();
                    },
                    height: 40,
                    isLoading: false),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Contact",
                        style: const TextStyle(
                            color: primaryColor, fontWeight: FontWeight.w500),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 4),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w500),
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
