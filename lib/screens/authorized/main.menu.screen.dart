import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:user_frontend_mybarber/const/colors.const.dart';
import 'package:user_frontend_mybarber/screens/authorized/booking/booking.screen.dart';
import 'package:user_frontend_mybarber/screens/authorized/home.screen.dart';
import 'package:user_frontend_mybarber/screens/authorized/profile.screen.dart';

class MainMenuScreen extends StatefulWidget {
  final int selectedPage;
  MainMenuScreen({this.selectedPage = 0});
  @override
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class _MainMenuScreenState extends State<MainMenuScreen> {
  @override
  void initState() {
    super.initState();
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSettings = InitializationSettings(iOS: initializationSettingsIOs);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) {
    return Navigator.pushReplacementNamed(context, payload);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      resizeToAvoidBottomInset: false,
      tabBar: CupertinoTabBar(
        activeColor: ColorApp.primaryColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.news),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled),
            label: 'Profile',
          ),
        ],
      ),
      controller: CupertinoTabController(initialIndex: widget.selectedPage),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return HomeScreen();
            break;
          case 1:
            return BookingScreen();
            break;
          case 2:
            return ProfileScreen();
            break;
          default:
            return HomeScreen();
        }
      },
    );
  }
}
