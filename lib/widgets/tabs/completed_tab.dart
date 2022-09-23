import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:services_worker/widgets/sw_text.dart';

import '../../constants.dart';
import '../../helpers/methods.dart';
import '../../models/booking_model.dart';

class CompletedBookingTab extends StatefulWidget {
  final List<Booking>? bookingList;
  const CompletedBookingTab({Key? key, required this.bookingList})
      : super(key: key);

  @override
  State<CompletedBookingTab> createState() => _CompletedBookingTabState();
}

class _CompletedBookingTabState extends State<CompletedBookingTab> {
  List<Booking> completedBookings = [];
  void alterRatings(Map rating, int i) {
    completedBookings[i].rating = rating;
    setState(() {});
  }

  @override
  void initState() {
    if (widget.bookingList != null) {
      completedBookings = widget.bookingList!
          .where((element) =>
              element.bookingStatus == "completed" ||
              element.bookingStatus == "cancelled" ||
              element.bookingStatus == "rejected" ||
              element.bookingDate
                      .add(const Duration(minutes: 180))
                      .millisecondsSinceEpoch <
                  DateTime.now().millisecondsSinceEpoch)
          .toList();
      completedBookings.sort((a, b) => b.id.compareTo(a.id));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 2),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 4),
        shrinkWrap: true,
        itemCount: completedBookings.length,
        itemBuilder: (context, index) {
          return Card(
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
                      SwText("Id: ${completedBookings[index].id}",
                          size: 14, color: primaryColor),
                      Row(
                        children: [
                          GestureDetector(
                              // onTap: () => downloadPdf(),
                              child:
                                  const Icon(Icons.timer_outlined, size: 22)),
                          const SizedBox(width: 4),
                          Text(
                              "${durationToString(completedBookings[index].bookingDuration)} Hr."),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: SwText(
                        "Date: ${DateFormat("MMM dd,yy hh:mm a").format(completedBookings[index].bookingDate)}",
                        size: 12,
                        color: Colors.grey),
                  ),
                  SwText("Customer: ${completedBookings[index].customerName}",
                      size: 14),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: SwText(
                        "Amount: ₹${completedBookings[index].bookingTotal}",
                        size: 14),
                  ),
                  completedBookings[index].bookingStatus != "completed"
                      ? const Divider()
                      : completedBookings[index].rating.isEmpty
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: RatingBar.builder(
                                initialRating: completedBookings[index]
                                    .rating["stars"]
                                    .toDouble(),
                                minRating: 1,
                                itemSize: 20,
                                ignoreGestures: true,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 1),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {},
                              ),
                            ),
                  completedBookings[index].bookingStatus != "completed"
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: SwText(
                              completedBookings[index].bookingStatus ==
                                      "rejected"
                                  ? "Rejected"
                                  : completedBookings[index].bookingStatus ==
                                          "cancelled"
                                      ? "Cancelled"
                                      : "Expired",
                              color: Colors.red),
                        )
                      : completedBookings[index].rating.isEmpty
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(top: 6, bottom: 2),
                              child: SwText(
                                  "${completedBookings[index].rating["desc"]}",
                                  size: 13,
                                  color: Colors.grey),
                            ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
