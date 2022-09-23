import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:services_worker/providers/booking_provider.dart';
import 'package:services_worker/widgets/sw_text.dart';
import '../../constants.dart';
import '../../helpers/methods.dart';
import '../../models/booking_model.dart';
import '../../providers/worker_provider.dart';
import '../../services/booking_service.dart';
import '../../widgets/sw_button.dart';

class BookingSession extends StatefulWidget {
  final Booking? booking;
  const BookingSession({Key? key, required this.booking}) : super(key: key);

  @override
  State<BookingSession> createState() => _BookingSessionState();
}

class _BookingSessionState extends State<BookingSession> {
  int totalHours = 0;
  int totalMinutes = 0;
  @override
  Widget build(BuildContext context) {
    BookingProvider bookingProvider = Provider.of<BookingProvider>(context);
    WorkerProvider workerProvider = Provider.of<WorkerProvider>(context);
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
                      SwText("Id: ${widget.booking!.id}",
                          size: 16, color: primaryColor),
                      Row(
                        children: [
                          GestureDetector(
                              // onTap: () => downloadPdf(),
                              child:
                                  const Icon(Icons.timer_outlined, size: 22)),
                          const SizedBox(width: 4),
                          Text(
                              "${durationToString(widget.booking!.bookingDuration)} Hr."),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: SwText(
                        "Date: ${DateFormat("MMM dd,yy hh:mm a").format(widget.booking!.bookingDate)}",
                        size: 14,
                        color: Colors.grey),
                  ),
                  SwText("Customer: ${widget.booking!.customerName}", size: 14),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: SwText("Amount: ₹${widget.booking!.bookingTotal}",
                        size: 14),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2, bottom: 8),
                    child: SwText(
                        "Address: ${widget.booking!.address.toString()}",
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
              text:
                  "Request ₹${workerProvider.getWorker.hourlyRate * totalHours + (workerProvider.getWorker.hourlyRate * totalMinutes / 60)}",
              func: () async {
                if (workerProvider.getWorker.hourlyRate * totalHours +
                        (workerProvider.getWorker.hourlyRate *
                            totalMinutes /
                            60) !=
                    0) {
                  var bookingData = await BookingService().updateBooking(
                      widget.booking!.id,
                      "requested",
                      widget.booking!.workerId,
                      widget.booking!.customerId,
                      bookingProvider.socket,
                      (workerProvider.getWorker.hourlyRate * totalHours +
                          workerProvider.getWorker.hourlyRate *
                              totalMinutes ~/
                              60),
                      (totalHours * 60 + totalMinutes));
                  if (bookingData != null) {
                    bookingProvider.setBooking(bookingData);
                    bookingProvider.paymentRequest();
                  }
                }
              },
              isLoading: false)
        ],
      ),
    );
  }
}
