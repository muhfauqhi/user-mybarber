import 'package:user_frontend_mybarber/models/barber.dart';
import 'package:user_frontend_mybarber/models/barber.details.dart';
import 'package:user_frontend_mybarber/models/user.dart';

class ModelBooking {
  bool status;
  String message;
  List<Booking> booking;

  ModelBooking({this.status, this.message, this.booking});

  ModelBooking.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      booking = new List<Booking>();
      json['data'].forEach((v) {
        booking.add(new Booking.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.booking != null) {
      data['data'] = this.booking.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Booking {
  String sId;
  int rating;
  String status;
  String bookDate;
  String bookingId;
  String createdAt;
  String updatedAt;
  int iV;
  User user;
  Barber barber;
  List<ServiceId> service;

  Booking(
      {this.sId,
      this.rating,
      this.status,
      this.bookDate,
      this.bookingId,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.user,
      this.barber,
      this.service});

  Booking.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    rating = json['rating'];
    status = json['status'];
    bookDate = json['bookDate'];
    bookingId = json['bookingId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    barber =
        json['barber'] != null ? new Barber.fromJson(json['barber']) : null;
    if (json['service'] != null) {
      service = new List<ServiceId>();
      json['service'].forEach((v) {
        service.add(new ServiceId.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['rating'] = this.rating;
    data['status'] = this.status;
    data['bookDate'] = this.bookDate;
    data['bookingId'] = this.bookingId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.barber != null) {
      data['barber'] = this.barber.toJson();
    }
    if (this.service != null) {
      data['service'] = this.service.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
