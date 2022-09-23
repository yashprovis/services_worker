import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:services_worker/constants.dart';
import 'package:services_worker/dummy.dart';
import 'package:services_worker/screens/tabs/invoice_preview.dart';

import 'package:services_worker/widgets/sw_text.dart';

import '../../helpers/methods.dart';
import '../../models/booking_model.dart';
import '../../services/booking_service.dart';

class InvoiceScreen extends StatefulWidget {
  static const routeName = "/invoice";
  const InvoiceScreen({Key? key}) : super(key: key);

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  List<Booking>? allBooking;
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    allBooking = await BookingService().fetchAllWorkerBookings();
    if (allBooking != null) {
      allBooking = allBooking!
          .where((element) => element.bookingStatus == "completed")
          .toList();
      allBooking!.sort((a, b) => b.id.compareTo(a.id));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 56, left: 16, right: 16),
      child: Column(
        ///  physics: NeverScrollableScrollPhysics(),

        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 24,
                  //color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              const SwText(
                "Invoices",
                // color: Colors.white,
                size: 20,
                //   weight: FontWeight.w500,
              )
            ],
          ),
          allBooking == null
              ? SizedBox(
                  height: MediaQuery.of(context).size.height - 200,
                  child: Center(child: CircularProgressIndicator()))
              : allBooking!.isEmpty
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height - 200,
                      child: const Center(
                        child: SwText("No completed bookings."),
                      ),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height - 80,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          shrinkWrap: true,
                          itemCount: allBooking!.length,
                          //  physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    InvoicePreview.routeName,
                                    arguments: {
                                      "id": allBooking![index].id,
                                      "invoice": allBooking![index].invoice
                                    });
                              },
                              child: Card(
                                elevation: 2,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 6),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 5),
                                              SwText(
                                                  "Id: ${allBooking![index].id}",
                                                  size: 14,
                                                  color: primaryColor),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 6),
                                                child: SwText(
                                                    "Date: ${DateFormat("MMM dd,yy hh:mm a").format(allBooking![index].bookingDate)}",
                                                    size: 12,
                                                    color: Colors.grey),
                                              ),
                                              SwText(
                                                  "Customer: ${allBooking![index].customerName}",
                                                  size: 14),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 6),
                                                child: SwText(
                                                    "Amount: ₹${allBooking![index].bookingTotal}",
                                                    size: 14),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 60,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                    onTap: () => downloadPdf(
                                                        allBooking![index]
                                                            .invoice!),
                                                    child: const Icon(
                                                        Icons.download)),
                                                const SizedBox(width: 10),
                                                GestureDetector(
                                                    onTap: () => sharePdf(
                                                        allBooking![index]
                                                            .invoice!),
                                                    child: const Icon(
                                                        Icons.share)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
        ],
      ),
    ));
  }
}
