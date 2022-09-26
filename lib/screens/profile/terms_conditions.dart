import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../widgets/sw_text.dart';

class TermsConditions extends StatelessWidget {
  static const routeName = "/termsConditions";
  const TermsConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(padding: EdgeInsets.only(top: 56), children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 22),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                const SwText(
                  "Terms and Conditions",
                  size: 20,
                )
              ],
            ),
          ),
          Container(
            height: 160,
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(gradient: appGradient),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            child: Image.asset("assets/images/logo.png"),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SwText(
                    "Please read these Terms and Conditions carefully before our app operated by Provis Technologies.",
                    size: 14),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: SwText("Conditions of use",
                      size: 16, weight: FontWeight.w600),
                ),
                SwText(
                    "By using this website, you certify that you have read and reviewed this Agreement and that you agree to comply with its terms. If you do not want to be bound by the terms of this Agreement, you are advised to leave the website accordingly. Provis Technologies only grants use and access of this website, its products, and its services to those who have accepted its terms.",
                    size: 12),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: SwText("Intellectual property",
                      size: 16, weight: FontWeight.w600),
                ),
                SwText(
                    "You agree that all materials, products, and services provided on this website are the property of Provis Technologies, its affiliates, directors, officers, employees, agents, suppliers, or licensors including all copyrights, trade secrets, trademarks, patents, and other intellectual property. You also agree that you will not reproduce or redistribute the Provis Technologies's intellectual property in any way, including electronic, digital, or new trademark registrations.\n\nYou grant Provis Technologies a royalty-free and non-exclusive license to display, use, copy, transmit, and broadcast the content you upload and publish. For issues regarding intellectual property claims, you should contact the company in order to come to an agreement. ",
                    size: 12),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: SwText("Age restriction",
                      size: 16, weight: FontWeight.w600),
                ),
                SwText(
                    "You must be at least 18 (eighteen) years of age before you can use this website. By using this website, you warrant that you are at least 18 years of age and you may legally adhere to this Agreement. Provis Technologies assumes no responsibility for liabilities related to age misrepresentation.",
                    size: 12),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: SwText("Privacy policy",
                      size: 16, weight: FontWeight.w600),
                ),
                SwText(
                    "Before you continue using our website, we advise you to read our privacy policy regarding our user data collection. It will help you better understand our practices.",
                    size: 12),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: SwText("User accounts",
                      size: 16, weight: FontWeight.w600),
                ),
                SwText(
                    "As a user of this website, you may be asked to register with us and provide private information. You are responsible for ensuring the accuracy of this information, and you are responsible for maintaining the safety and security of your identifying information. You are also responsible for all activities that occur under your account or password. If you think there are any possible issues regarding the security of your account on the website, inform us immediately so we may address them accordingly. We reserve all rights to terminate accounts, edit or remove content and cancel orders at our sole discretion.",
                    size: 12),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: SwText("Applicable law",
                      size: 16, weight: FontWeight.w600),
                ),
                SwText(
                    "By visiting this website, you agree that the laws of the India, without regard to principles of conflict laws, will govern these terms and conditions, or any dispute of any sort that might come between Provis Technologies and you, or its business partners and associates.",
                    size: 12),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: SwText("Disputes", size: 16, weight: FontWeight.w600),
                ),
                SwText(
                    "Any dispute related in any way to your visit to this website or to products you purchase from us shall be arbitrated by state or federal court India and you consent to exclusive jurisdiction and venue of such courts.",
                    size: 12),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: SwText("Indemnification",
                      size: 16, weight: FontWeight.w600),
                ),
                SwText(
                    "You agree to indemnify Provis Technologies and its affiliates and hold Provis Technologies harmless against legal claims and demands that may arise from your use or misuse of our services. We reserve the right to select our own legal counsel. ",
                    size: 12),
              ],
            ),
          )
        ]));
  }
}
