import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_frontend_mybarber/const/colors.const.dart';
import 'package:user_frontend_mybarber/models/barber.dart';
import 'package:user_frontend_mybarber/screens/authorized/booking/barber.details.screen.dart';

class BarberCard extends StatelessWidget {
  final Barber barber;
  const BarberCard({
    Key key,
    this.barber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: ColorApp.greyColor,
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 35,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    barber.name,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Hair Stylist',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        size: 16.0,
                        color: Colors.orangeAccent,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        '${barber.rating.toStringAsFixed(1)}',
                        style: TextStyle(
                          fontSize: 14.0,
                          letterSpacing: 1,
                          color: ColorApp.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              left: 100,
              bottom: -100,
              child: FadeInImage.assetNetwork(
                width: 220,
                placeholder: 'assets/notavailableimage.png',
                image: '${barber.image}',
              ),
            ),
            Positioned(
              top: 125,
              left: 20,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: ColorApp.seaGreenColor,
                child: Text(
                  'Book now',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => BarberDetailsScreen(
                        barber: barber,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
