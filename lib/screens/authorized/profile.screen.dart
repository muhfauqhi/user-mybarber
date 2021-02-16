import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_frontend_mybarber/const/colors.const.dart';
import 'package:user_frontend_mybarber/const/custom.navigation.bar.dart';
import 'package:user_frontend_mybarber/controllers/login.controller.dart';
import 'package:user_frontend_mybarber/controllers/profile.controller.dart';
import 'package:user_frontend_mybarber/models/user.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = ProfileController();

  final LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    List _menuList = [
      {
        'title': 'My Vouchers',
        'icon': CupertinoIcons.info,
      },
      {
        'title': 'Get Your Rewards',
        'icon': CupertinoIcons.tag,
      },
    ];

    List _menuListNotLogin = [
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
      navigationBar: CustomNavigationBar(heroTag: 'profile'),
      resizeToAvoidBottomInset: false,
      child: FutureBuilder(
        future: profileController.dashboard(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CupertinoActivityIndicator());
          }
          if (snapshot.data == null) {
            return Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        'assets/bg-2.png',
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                      height: 200,
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 100.0),
                        child: CupertinoButton(
                          color: ColorApp.primaryColor,
                          onPressed: () {
                            Navigator.pushNamed(context, 'login');
                          },
                          child: Text(
                            'Sign in or Sign up',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _menuListNotLogin.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          trailing: _menuListNotLogin[index]['trailing']
                              ? Icon(
                                  CupertinoIcons.right_chevron,
                                )
                              : Text(
                                  '1.0.0',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                          title: Text(
                            '${_menuListNotLogin[index]['title']}',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            User user = snapshot.data;
            return Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  color: ColorApp.primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              '${user.fullname}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${phoneFormat(user.phone)}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'settings');
                        },
                        child: Icon(
                          CupertinoIcons.gear_solid,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _menuList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Icon(_menuList[index]['icon']),
                          trailing: Icon(CupertinoIcons.right_chevron),
                          title: Text(
                            '${_menuList[index]['title']}',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  String phoneFormat(String phone) {
    String s = '+62 ' + phone.substring(3);
    return s;
  }
}
