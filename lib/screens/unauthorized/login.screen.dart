import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_frontend_mybarber/const/colors.const.dart';
import 'package:user_frontend_mybarber/const/custom.navigation.bar.dart';
import 'package:user_frontend_mybarber/const/form.field.const.dart';
import 'package:user_frontend_mybarber/controllers/login.controller.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = LoginController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CustomNavigationBar(heroTag: 'login'),
      backgroundColor: ColorApp.primaryColor,
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sign in to My Barber and continue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Text(
                  'Enter your email and password below to continue to the My arber and let the cuts begin!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                // Username or Email Text Form Field
                CustomFormField(
                  controller: username,
                  hintText: 'Username or Email',
                  icon: Icons.account_circle,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                // Password Text Form Field
                CustomFormField(
                  controller: password,
                  hintText: 'Password',
                  icon: Icons.lock,
                  obscureText: _obscure,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CupertinoButton(
                    onPressed: () async {
                      String message = await loginController.login(
                          username.text, password.text);
                      if (username.text == '' || password.text == '') {
                        message = 'Username and Password can\'t be empty';
                      }
                      if (message == 'Login Success') {
                        Navigator.pop(context);
                        return;
                      }

                      showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            content: Text('$message'),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: Text('OK'),
                                onPressed: () => Navigator.pop(context),
                              )
                            ],
                          );
                        },
                      );
                    },
                    color: ColorApp.secondaryColor,
                    child: Text('Sign in',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Forgot Password',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                    GestureDetector(
                      child: Text(
                        'Create an account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ColorApp.secondaryColor, fontSize: 14),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, 'register');
                      },
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      // Image.asset(
                      //   'assets/cartenz-logo-white.png',
                      //   height: MediaQuery.of(context).size.height * 0.2,
                      // ),
                      Text(
                        'This App Develop by Fauqhi Fikriansyah ™',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w100),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
