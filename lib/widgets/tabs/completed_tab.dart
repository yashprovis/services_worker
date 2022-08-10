import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';
import '../sw_text.dart';

class CompletedBookingTab extends StatelessWidget {
  const CompletedBookingTab({Key? key}) : super(key: key);

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
                          "Date: ${DateFormat("MMM dd,yy hh:mm a").format(DateTime.now())}",
                          size: 12,
                          color: Colors.grey),
                    ),
                    const SwText("Customer: Ravi Provis", size: 14),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: const SwText("Amount: ₹4,000.00", size: 14),
                    ),
                    RatingBar.builder(
                      initialRating: index + 1,
                      minRating: 1,
                      itemSize: 16,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      ignoreGestures: true,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 1),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: SwText(
                          "\"Good Professionals, Nice service, Recommend 100%\"",
                          size: 12,
                          color: Colors.grey),
                    ),
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
