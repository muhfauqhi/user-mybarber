import 'dart:convert';

import 'package:user_frontend_mybarber/models/barber.dart';
import 'package:user_frontend_mybarber/models/barber.details.dart';
import 'package:user_frontend_mybarber/models/booking.dart';
import 'package:user_frontend_mybarber/models/service.dart';
import 'package:user_frontend_mybarber/services/user_services.dart';

class BarberController {
  final UserService userService = UserService();

  Future getBarberToday() async {
    try {
      var response = await userService.getBarberToday();
      ModelBarber model = ModelBarber.fromJson(jsonDecode(response.body));
      List<Barber> barber = model.barber;
      // List<Booking> booking = await bookingController.getBooking();
      var responseBooking = await userService.getBookingAll();
      ModelBooking modelBooking =
          ModelBooking.fromJson(jsonDecode(responseBooking.body));
      List<Booking> booking = modelBooking.booking;

      barber.map((barber) {
        int rating = 0;
        int totalRating = 0;
        barber.image = 'http://localhost:3000/' + barber.image.substring(19);
        booking.map((book) {
          if (book.barber.sId == barber.sId &&
              book.status == 'Finished' &&
              book.rating > 0) {
            rating += book.rating;
            totalRating++;
          }
        }).toList();
        double finalRating = rating / totalRating;
        if (finalRating.isNaN) {
          barber.rating = 0.0;
        } else {
          barber.rating = rating / totalRating;
        }
      }).toList();
      return barber;
    } catch (error) {
      return null;
    }
  }

  Future getBarberDetails(String id) async {
    try {
      var response = await userService.getBarberDetails(id);
      ModelBarberDetails model =
          ModelBarberDetails.fromJson(jsonDecode(response.body));
      BarberDetails barberDetails = model.barberDetails;
      barberDetails.image =
          'http://localhost:3000/' + barberDetails.image.substring(19);
      return barberDetails;
    } catch (error) {
      return null;
    }
  }

  Future getBarberByService() async {
    try {
      var response = await userService.getService();
      ModelService modelService =
          ModelService.fromJson(jsonDecode(response.body));
      List<Service> service = modelService.service;
      return service;
    } catch (error) {
      return null;
    }
  }
}
