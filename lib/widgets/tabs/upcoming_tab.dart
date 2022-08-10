import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../constants.dart';
import '../sw_text.dart';

class UpcomingBookingTab extends StatelessWidget {
  const UpcomingBookingTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 4),
        shrinkWrap: true,
        itemCount: 6,
        //  physics: ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigator.of(context).pushNamed(InvoicePreview.routeName,
              //     arguments: "SW000${index + 1}");
            },
            child: Card(
              elevation: 2,
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
                        SwText("Booking No: SW000${index + 1}",
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
                          "Date: ${DateFormat("MMM dd,yy hh:mm a").format(DateTime.now().add(Duration(minutes: (index + 1) * 2000)))}",
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
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            "Contact",
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 20, right: 4),
                            child: const Text(
                              "Cancel",
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
