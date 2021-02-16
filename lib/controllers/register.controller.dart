import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_frontend_mybarber/models/token.dart';
import 'package:user_frontend_mybarber/services/user_services.dart';

class RegisterController {
  final UserService userService = UserService();

  Future register(String username, String fullname, String password,
      String email, String phone) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var response =
        await userService.register(username, fullname, password, email, phone);

    Token token = Token.fromJson(jsonDecode(response.body));
    String user = jsonEncode(token);
    if (token.status == true) {
      sharedPreferences.setString('user', user);
    }
    return token.message;
  }
}
