import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_frontend_mybarber/const/colors.const.dart';
import 'package:user_frontend_mybarber/const/custom.navigation.bar.dart';
import 'package:user_frontend_mybarber/controllers/login.controller.dart';

class SettingScreen extends StatelessWidget {
  final LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    List _menuList = [
      {
        'title': 'Languages',
        'trailing': true,
      },
      {
        'title': 'About Us',
        'trailing': true,
      },
      {
        'title': 'FAQs',
        'trailing': true,
      },
      {
        'title': 'Terms and Conditions',
        'trailing': true,
      },
      {
        'title': 'Privacy Policy',
        'trailing': true,
      },
      {
        'title': 'Contact Us',
        'trailing': true,
      },
      {
        'title': 'App Version',
        'trailing': false,
      },
    ];

    return CupertinoPageScaffold(
      navigationBar: CustomNavigationBar(heroTag: 'setting'),
      backgroundColor: ColorApp.primaryColor,
      child: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(
              top: 50.0,
            ),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: _menuList.length + 1,
              itemBuilder: (contex, index) {
                if (index == 7) {
                  return CupertinoButton(
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () {
                      loginController.logout();
                      Navigator.pop(context);
                    },
                  );
                }
                return Card(
                  child: ListTile(
                    trailing: _menuList[index]['trailing']
                        ? Icon(
                            CupertinoIcons.right_chevron,
                          )
                        : Text(
                            '1.0.0',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                    title: Text(
                      '${_menuList[index]['title']}',
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
