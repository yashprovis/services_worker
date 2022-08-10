import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:services_worker/providers/booking_provider.dart';
import 'package:services_worker/widgets/sw_text.dart';
import '../../constants.dart';
import '../../widgets/sw_button.dart';

class BookingSession extends StatefulWidget {
  const BookingSession({Key? key}) : super(key: key);

  @override
  State<BookingSession> createState() => _BookingSessionState();
}

class _BookingSessionState extends State<BookingSession> {
  int totalHours = 0;
  int totalMinutes = 0;
  @override
  Widget build(BuildContext context) {
    BookingProvider bookingProvider = Provider.of<BookingProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        children: [
          Card(
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
                              child:
                                  const Icon(Icons.timer_outlined, size: 22)),
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
                    child: SwText("Amount: ₹4,000.00", size: 14),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: SwText(
                        "Address: 503, Signature Tower, Tonk Phatak, Jaipur - 302006",
                        size: 12,
                        color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
          //   SizedBox(height: MediaQuery.of(context).size.height - 350),
//          SizedBox.

          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 10, bottom: 20, right: 10),
            child: SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SwText("Total work time:"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 30,
                        child: ListWheelScrollView(
                            itemExtent: 36,
                            onSelectedItemChanged: (i) => setState(() {
                                  totalHours = i;
                                }),
                            physics: const FixedExtentScrollPhysics(),
                            children: List.generate(
                                10,
                                (index) => Center(
                                        child: SwText(
                                      index.toString(),
                                      color: primaryColor,
                                    )))),
                      ),
                      const SwText("Hrs.", size: 14),
                      SizedBox(
                        width: 30,
                        child: ListWheelScrollView(
                            itemExtent: 36,
                            onSelectedItemChanged: (i) => setState(() {
                                  totalMinutes = i * 15;
                                }),
                            physics: const FixedExtentScrollPhysics(),
                            children: List.generate(
                                4,
                                (index) => Center(
                                        child: SwText(
                                      ((index) * 15).toString(),
                                      color: primaryColor,
                                    )))),
                      ),
                      const SwText("Mins", size: 14),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SwButton(
              text: "Request ₹${100 * totalHours + (totalMinutes * 100 / 60)}",
              func: () {},
              isLoading: false)
        ],
      ),
    );
  }
}
