import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:user_frontend_mybarber/const/barber.card.dart';
import 'package:user_frontend_mybarber/const/colors.const.dart';
import 'package:user_frontend_mybarber/const/custom.navigation.bar.dart';
import 'package:user_frontend_mybarber/controllers/barber.controller.dart';
import 'package:user_frontend_mybarber/models/barber.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BarberController barberController = BarberController();
  final CarouselController carouselController = CarouselController();
  final TextEditingController searchController = TextEditingController();
  bool scaffold = true;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CustomNavigationBar(heroTag: 'home'),
      resizeToAvoidBottomInset: false,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(height: 50.0),
          Padding(
            padding: EdgeInsets.only(left: 30.0, top: 30.0, bottom: 20.0),
            child: Text(
              'Today Hair Stylist',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Material(
              borderRadius: BorderRadius.circular(20.0),
              elevation: 5.0,
              child: CupertinoTextField(
                controller: searchController,
                onChanged: (text) {
                  setState(() {
                    scaffold = false;
                  });
                  if (searchController.text == '') {
                    setState(() {
                      scaffold = true;
                    });
                  }
                },
                cursorColor: ColorApp.seaGreenColor,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.all(8.0),
                prefix: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    CupertinoIcons.search,
                    color: ColorApp.seaGreenColor,
                  ),
                ),
                placeholder: 'What service do you want?',
              ),
            ),
          ),
          SizedBox(height: 25.0),
          FutureBuilder(
            future: barberController.getBarberToday(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return ShimmerBarberCard();
              else if (snapshot.data == null) {
                return ShimmerBarberCard();
              } else {
                List<Barber> _barberList = snapshot.data;
                return CarouselSlider.builder(
                  carouselController: carouselController,
                  options: CarouselOptions(
                    autoPlay: true,
                    height: 200,
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    pageViewKey: PageStorageKey(carouselController),
                  ),
                  itemCount: _barberList.length,
                  itemBuilder: (context, index) {
                    return BarberCard(barber: _barberList[index]);
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class ShimmerBarberCard extends StatelessWidget {
  const ShimmerBarberCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorApp.greyColor,
      highlightColor: Colors.grey[50],
      child: Container(
        height: 200,
        margin: EdgeInsets.symmetric(horizontal: 30.0),
        decoration: BoxDecoration(
          color: ColorApp.greyColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
