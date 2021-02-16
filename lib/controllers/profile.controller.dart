import 'dart:convert';

import 'package:user_frontend_mybarber/controllers/login.controller.dart';
import 'package:user_frontend_mybarber/models/token.dart';
import 'package:user_frontend_mybarber/models/user.dart';
import 'package:user_frontend_mybarber/services/user_services.dart';

class ProfileController {
  final UserService userService = UserService();
  final LoginController loginController = LoginController();

  Future dashboard() async {
    try {
      Token token = await loginController.checkAuth();
      if (token == null)
        return null;
      else {
        var response = await userService.dashboard(token.token);
        ModelUser model = ModelUser.fromJson(jsonDecode(response.body));
        User user = model.user;
        return user;
      }
    } catch (error) {
      return null;
    }
  }
}
