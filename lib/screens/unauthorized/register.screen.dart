import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_frontend_mybarber/const/colors.const.dart';
import 'package:user_frontend_mybarber/const/custom.navigation.bar.dart';
import 'package:user_frontend_mybarber/const/form.field.const.dart';
import 'package:user_frontend_mybarber/controllers/register.controller.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController registerController = RegisterController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CustomNavigationBar(heroTag: 'register'),
      backgroundColor: ColorApp.primaryColor,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 70.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  Text(
                    'Sign up to My Barber and continue',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Text(
                    'Enter the form below to continue to the My Barber and let the cuts begin!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  // Username Text Form Field
                  CustomFormField(
                    controller: username,
                    hintText: 'Username',
                    icon: Icons.account_circle,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  // Email Text Form Field
                  CustomFormField(
                    controller: email,
                    hintText: 'Email',
                    icon: Icons.mail_outline,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  // Full name Text Form Field
                  CustomFormField(
                    controller: fullName,
                    hintText: 'Full Name',
                    icon: Icons.person_outline,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  // Phone number Text Form Field
                  CustomFormField(
                    controller: phoneNumber,
                    hintText: 'Phone number',
                    icon: Icons.phone,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  CustomFormField(
                    controller: password,
                    hintText: 'Password',
                    icon: Icons.lock,
                    obscureText: _obscure,
                    suffixIcon: GestureDetector(
                      child: _obscure
                          ? Icon(
                              Icons.visibility_off,
                              color: Colors.white,
                              size: 20.0,
                            )
                          : Icon(
                              Icons.visibility,
                              color: Colors.white,
                              size: 20.0,
                            ),
                      onTap: () {
                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  CustomFormField(
                    controller: confirmPassword,
                    hintText: 'Confirm Password',
                    icon: Icons.lock,
                    obscureText: _obscure,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CupertinoButton(
                      onPressed: () async {
                        String message = await registerController.register(
                            username.text,
                            fullName.text,
                            password.text,
                            email.text,
                            phoneNumber.text);
                        if (username.text == '' ||
                            fullName.text == '' ||
                            password.text == '' ||
                            email.text == '' ||
                            phoneNumber.text == '') {
                          message = 'All form have to be complete';
                        }
                        if (message == 'Success') {
                          Navigator.pop(context);
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
                      child: Text('Sign Up',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
