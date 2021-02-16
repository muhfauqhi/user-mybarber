import 'package:flutter/material.dart';
import 'package:user_frontend_mybarber/const/colors.const.dart';

class GettingStartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.primaryColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Image.asset(
              //   'assets/cartenz-logo-white.png',
              //   width: MediaQuery.of(context).size.width * 0.5,
              // ),
              // SizedBox(height: 20),
              Text(
                'Welcome to My Barber!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
              SizedBox(height: 20),
              Text(
                'This is My Barber mobile application to booking your appointment with the hair stylist',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                  color: Color(0xffC2B280),
                  elevation: 0,
                  height: 50,
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Get Started',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                  textColor: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
