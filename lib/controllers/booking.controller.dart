import 'dart:convert';

import 'package:user_frontend_mybarber/controllers/login.controller.dart';
import 'package:user_frontend_mybarber/models/booking.dart';
import 'package:user_frontend_mybarber/models/response.dart';
import 'package:user_frontend_mybarber/models/token.dart';
import 'package:user_frontend_mybarber/services/user_services.dart';

class BookingController {
  final UserService userService = UserService();
  final LoginController loginController = LoginController();

  Future createBooking(
      String serviceId, String bookDate, String barberId) async {
    try {
      Token token = await loginController.checkAuth();
      if (token == null) return null;
      var response = await userService.createBooking(
          serviceId, bookDate, barberId, token.token);
      ModelResponse modelResponse =
          ModelResponse.fromJson(jsonDecode(response.body));
      return modelResponse;
    } catch (error) {
      return null;
    }
  }

  Future getBooking() async {
    try {
      Token token = await loginController.checkAuth();
      if (token == null)
        return null;
      else {
        var response = await userService.getBooking(token.token);
        ModelBooking model = ModelBooking.fromJson(jsonDecode(response.body));
        if (model.booking.length < 1) return null;
        List<Booking> booking = model.booking;
        booking
            .map((e) => e.barber.image =
                'http://localhost:3000/' + e.barber.image.substring(19))
            .toList();
        return booking;
      }
    } catch (error) {
      return null;
    }
  }

  Future updateBookingRating(String id, int rating) async {
    Token token = await loginController.checkAuth();
    var response =
        await userService.updateBookingRating(id, rating, token.token);
    ModelResponse modelResponse =
        ModelResponse.fromJson(jsonDecode(response.body));
    return modelResponse;
  }

  Future getRating() async {
    var response = await userService.getBookingAll();
    ModelBooking modelBooking =
        ModelBooking.fromJson(jsonDecode(response.body));
    return modelBooking.booking;
  }
}
