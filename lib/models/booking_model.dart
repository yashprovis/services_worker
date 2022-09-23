import 'dart:convert';

import 'address_model.dart';

Booking bookingFromJson(String str) => Booking.fromJson(json.decode(str));

String bookingToJson(Booking data) => json.encode(data.toJson());

class Booking {
  Booking(
      {required this.id,
      required this.bookingStatus,
      required this.bookingDate,
      required this.bookingDuration,
      required this.bookingTotal,
      required this.bookingOtp,
      required this.customerName,
      required this.customerId,
      required this.workerName,
      required this.workerId,
      required this.address,
      required this.rating,
      this.invoice,
      required this.workerPhone});

  final String id;
  final String bookingStatus;
  final DateTime bookingDate;
  final int bookingDuration;
  final int bookingTotal;
  final String bookingOtp;
  final String customerName;
  final String customerId;
  final String workerName;
  final String workerPhone;
  final String workerId;
  final Address address;
  Map rating;
  final String? invoice;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
      id: json["_id"],
      bookingStatus: json["bookingStatus"],
      bookingDate: DateTime.parse(json["bookingDate"]),
      bookingDuration: json["bookingDuration"],
      bookingTotal: json["bookingTotal"],
      bookingOtp: json["bookingOTP"],
      customerName: json["customerName"],
      customerId: json["customerId"],
      workerName: json["workerName"],
      workerId: json["workerId"],
      rating: json["rating"] ?? {},
      address: Address.fromJson(json["address"]),
      workerPhone: json["workerPhone"],
      invoice: json["invoice"]);

  Map<String, dynamic> toJson() => {
        "bookingStatus": bookingStatus,
        "bookingDate": bookingDate.toIso8601String(),
        "bookingDuration": bookingDuration,
        "bookingTotal": bookingTotal,
        "customerName": customerName,
        "customerId": customerId,
        "workerName": workerName,
        "workerId": workerId,
        "workerPhone": workerPhone,
        "address": address.toJson(),
      };
}
