import 'package:flutter/material.dart';

class BookingProvider extends ChangeNotifier {
  int bookingStatus = 0;

  int get getBookingStatus => bookingStatus;

  startBooking() {
    bookingStatus = 1;
    notifyListeners();
  }

  paymentRequest() {
    bookingStatus = 2;
    notifyListeners();
  }

  paymentDone() {
    bookingStatus = 3;
    notifyListeners();
  }

  completeBooking() {
    bookingStatus = 0;
    notifyListeners();
  }
}
