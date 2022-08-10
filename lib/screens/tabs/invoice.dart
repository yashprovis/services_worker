import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:services_worker/constants.dart';
import 'package:services_worker/dummy.dart';
import 'package:services_worker/screens/tabs/invoice_preview.dart';

import 'package:services_worker/widgets/sw_text.dart';

class InvoiceScreen extends StatelessWidget {
  static const routeName = "/invoice";
  const InvoiceScreen({Key? key}) : super(key: key);

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
          SizedBox(
            height: MediaQuery.of(context).size.height - 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 4),
                shrinkWrap: true,
                itemCount: 6,
                //  physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(InvoicePreview.routeName,
                          arguments: "SW000${index + 1}");
                    },
                    child: Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 6),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SwText("Booking No: SW000${index + 1}",
                                        size: 14, color: primaryColor),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: SwText(
                                          "Date: ${DateFormat("MMM dd,yy hh:mm a").format(DateTime.now())}",
                                          size: 12,
                                          color: Colors.grey),
                                    ),
                                    const SwText("Customer: Ravi Provis",
                                        size: 14),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 4),
                                      child: const SwText("Amount: ₹4,000.00",
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
                                          onTap: () => downloadPdf(),
                                          child: const Icon(Icons.download)),
                                      const SizedBox(width: 10),
                                      GestureDetector(
                                          onTap: () => sharePdf(),
                                          child: const Icon(Icons.share)),
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
