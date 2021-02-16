import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_frontend_mybarber/screens/authorized/booking/barber.details.screen.dart';
import 'package:user_frontend_mybarber/screens/authorized/main.menu.screen.dart';
import 'package:user_frontend_mybarber/screens/authorized/setting.screen.dart';
import 'package:user_frontend_mybarber/screens/unauthorized/login.screen.dart';
import 'package:user_frontend_mybarber/screens/unauthorized/register.screen.dart';

void main() => {runApp(MyApp())};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      initialRoute: '/',
      routes: {
        '/': (_) => MainMenuScreen(selectedPage: 0),
        'login': (_) => LoginScreen(),
        'barber': (_) => BarberDetailsScreen(),
        'register': (_) => RegisterScreen(),
        'booking': (_) => MainMenuScreen(selectedPage: 1),
        'settings': (_) => SettingScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
