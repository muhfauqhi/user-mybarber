import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_frontend_mybarber/models/token.dart';
import 'package:user_frontend_mybarber/services/user_services.dart';

class LoginController {
  final UserService userService = UserService();

  Future checkAuth() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      Map user = jsonDecode(sharedPreferences.getString('user'));
      Token token = Token.fromJson(user);
      return token;
    } catch (error) {
      return null;
    }
  }

  Future login(String username, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var response = await userService.login(username, password);

    Token token = Token.fromJson(jsonDecode(response.body));
    String user = jsonEncode(token);
    if (token.status == true) {
      sharedPreferences.setString('user', user);
    }
    return token.message;
  }

  Future logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('user');
  }
}
