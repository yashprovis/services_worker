import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import '../models/booking_model.dart';

class BookingProvider extends ChangeNotifier {
  String? bookingStatus = "created";
  Booking? booking;
  io.Socket? socket;
  io.Socket? get getSocket => socket;
  Booking? get getBooking => booking;
  String get getBookingStatus => bookingStatus ?? "";
  updateSocket(io.Socket? newSocket) {
    socket = newSocket;
    notifyListeners();
  }

  setBooking(Booking? newBooking) {
    booking = newBooking;
    notifyListeners();
  }

  startBooking() {
    bookingStatus = "started";
    notifyListeners();
  }

  paymentRequest() {
    bookingStatus = "requested";
    notifyListeners();
  }

  completeBooking() {
    bookingStatus = "completed";
    notifyListeners();
  }

  resetBooking() {
    bookingStatus = null;
    notifyListeners();
  }
}
