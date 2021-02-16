import 'package:http/http.dart' as http;

const API_URL = 'http://localhost:3000/api/';

class UserService {
  getBarberToday() {
    return http.get(
      API_URL + '/barber/today',
    );
  }

  getService() {
    return http.get(API_URL + '/service');
  }

  getBarberByDay(String day) {
    return http.get(
      API_URL + '/barber/day/$day',
    );
  }

  getBarberDetails(String id) {
    return http.get(
      API_URL + 'barber/$id',
    );
  }

  createBooking(
      String serviceId, String bookDate, String barberId, String token) async {
    return http.post(
      API_URL + '/booking',
      body: {
        'barberId': barberId,
        'bookDate': bookDate,
        'serviceId': serviceId,
      },
      headers: {
        'Authorization': token,
      },
    );
  }

  getBooking(String token) async {
    return http.get(
      API_URL + 'booking/user',
      headers: {
        'Authorization': token,
      },
    );
  }

  dashboard(String token) async {
    return http.get(
      API_URL + 'dashboard',
      headers: {
        'Authorization': token,
      },
    );
  }

  register(String username, String fullname, String password, String email,
      String phone) {
    return http.post(
      API_URL + 'register',
      body: {
        'username': username,
        'fullname': fullname,
        'password': password,
        'email': email,
        'phone': phone
      },
    );
  }

  login(String username, String password) {
    return http.post(
      API_URL + 'login',
      body: {
        'username': username,
        'password': password,
      },
    );
  }

  updateBookingRating(String id, int rating, String token) {
    return http.put(
      API_URL + 'booking/$id',
      body: {
        'rating': rating.toString(),
      },
      headers: {
        'Authorization': token,
      },
    );
  }

  getBookingAll() {
    return http.get(API_URL + 'booking');
  }
}
