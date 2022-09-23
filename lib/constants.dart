import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:services_worker/screens/profile/edit_work.dart';
import 'package:services_worker/screens/profile/help_support.dart';
import 'package:services_worker/screens/profile/terms_conditions.dart';
import 'package:services_worker/screens/tabs/booking.dart';
import 'package:services_worker/screens/tabs/booking_history.dart';
import 'package:services_worker/screens/tabs/invoice.dart';
import 'package:services_worker/screens/tabs/profile.dart';

// const String firstNamePref = "FIRST_NAME";
// const String lastNamePref = "LAST_NAME";
// const String emailPref = "EMAIL";

// const String streetAddressPref = "STREET_ADDRESS";
// const String cityPref = "CITY";
// const String countryPref = "COUNTRY";

const Color primaryColor = Color(0xFF495C83);
const Color primaryLight = Color(0xFF7A86B6);
const Color secondaryColor = Color(0xFFA8A4CE);
const Color secondaryLight = Color(0xFFC8B6E2);

LinearGradient appGradient = LinearGradient(
    colors: [primaryLight, primaryLight.withOpacity(.5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);

InputBorder border = OutlineInputBorder(
  borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
  borderRadius: BorderRadius.circular(0),
);
InputBorder errorBorder = OutlineInputBorder(
  borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
  borderRadius: BorderRadius.circular(0),
);
const String tokenPref = "AUTH_TOKEN";

const String baseUrl = "https://460a-45-249-86-85.ngrok.io/api";
const String uploadUrl = "https://460a-45-249-86-85.ngrok.io/uploads";
Map<String, String> headerApiMap = {
  "Content-Type": "application/json; charset=utf-8",
  "Accept": "*/*"
};

const List homeItems = [
  {
    "name": "Booking",
    "route": BookingScreen.routeName,
    "icon": CupertinoIcons.cube_box
  },
  {
    "name": "Booking History",
    "route": BookingHistoryScreen.routeName,
    "icon": CupertinoIcons.arrow_counterclockwise_circle
  },
  {
    "name": "My Profile",
    "route": ProfileScreen.routeName,
    "icon": CupertinoIcons.person
  },
  {
    "name": "Invoices",
    "route": InvoiceScreen.routeName,
    "icon": CupertinoIcons.doc_chart
  }
];
const List profileItems = [
  {
    "name": "Work Settings",
    "route": EditWorkSettings.routeName,
    "icon": CupertinoIcons.settings
  },
  {
    "name": "Help and Support",
    "route": HelpSupport.routeName,
    "icon": CupertinoIcons.info
  },
  {
    "name": "Terms and Conditions",
    "route": TermsConditions.routeName,
    "icon": CupertinoIcons.doc
  },
  {
    "name": "Logout",
    //  "route": AddressScreen.routeName,
    "icon": CupertinoIcons.person_badge_minus
  }
];
