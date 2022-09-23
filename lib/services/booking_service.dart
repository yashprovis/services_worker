import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/booking_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class BookingService {
  Future<List<Booking>> fetchAllWorkerBookings() async {
    List<Booking> bookings = [];
    http.Response response = await http.get(
        // body: jsonEncode(),
        headers: headerApiMap,
        Uri.parse("$baseUrl/worker/bookings"));
    print(response.body);
    List data = jsonDecode(response.body)['data'];
    for (var element in data) {
      bookings.add(Booking.fromJson(element));
    }
    return bookings;
  }

  Future<Booking?> fetchLatestBooking() async {
    Booking? booking;
    http.Response response = await http.get(
        headers: headerApiMap, Uri.parse("$baseUrl/worker/latestBooking"));
    print(response.body);
    if (response.statusCode == 200) {
      booking = Booking.fromJson(jsonDecode(response.body)['data']);
      return booking;
    }
    return null;
  }

  Future<Booking?> updateBooking(String id, String status, String workerId,
      String userId, io.Socket? socket,
      [int? amount, int? minutes]) async {
    Booking? booking;
    Map body = {
      "bookingStatus": status,
    };
    if (amount != null) {
      body["bookingTotal"] = amount;
    }
    if (minutes != null) {
      body["bookingDuration"] = minutes;
    }
    if (socket != null) {
      socket.emit("update-booking", {
        "senderId": workerId,
        "receiverId": userId,
        "bookingStatus": status
      });
    }
    http.Response response = await http.post(
        body: jsonEncode(body),
        headers: headerApiMap,
        Uri.parse("$baseUrl/updateBooking/$id"));
    print(response.body);
    if (response.statusCode == 200) {
      booking = Booking.fromJson(jsonDecode(response.body)['data']);
      return booking;
    }
    return null;
  }
}
