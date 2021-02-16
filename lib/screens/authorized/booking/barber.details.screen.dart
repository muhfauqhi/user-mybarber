import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:user_frontend_mybarber/const/colors.const.dart';
import 'package:user_frontend_mybarber/controllers/barber.controller.dart';
import 'package:user_frontend_mybarber/controllers/booking.controller.dart';
import 'package:user_frontend_mybarber/controllers/login.controller.dart';
import 'package:user_frontend_mybarber/models/barber.dart';
import 'package:user_frontend_mybarber/models/barber.details.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:user_frontend_mybarber/models/response.dart';
import 'package:user_frontend_mybarber/screens/authorized/main.menu.screen.dart';

class BarberDetailsScreen extends StatefulWidget {
  final Barber barber;

  const BarberDetailsScreen({Key key, this.barber}) : super(key: key);

  @override
  _BarberDetailsScreenState createState() => _BarberDetailsScreenState();
}

class _BarberDetailsScreenState extends State<BarberDetailsScreen> {
  final BarberController barberController = BarberController();
  final BookingController bookingController = BookingController();
  final LoginController loginController = LoginController();

  ServiceId selectedService = ServiceId(
    name: '--Service Name--',
    duration: null,
  );

  DateTime now;
  DateTime maximumDate;
  DateTime selectedTime;
  double totalPrice;
  int bookingClosed = 24;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    now = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour + 1,
    );
    selectedTime = now;
    maximumDate = DateTime(
      now.year,
      now.month,
      now.day,
      24,
    );
    totalPrice = 0;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              // Background
              Container(
                height: MediaQuery.of(context).size.height / 3 + 20,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.asset(
                      'assets/bg-1.png',
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Color(0xff346D33).withOpacity(0.1),
                    ),
                  ],
                ),
              ),
              // Back Icon
              Positioned(
                top: 50,
                left: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    CupertinoIcons.back,
                    color: ColorApp.greyColor,
                    size: 30.0,
                  ),
                ),
              ),
              // Book Form
              Positioned(
                top: MediaQuery.of(context).size.height / 3 - 20,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 120),
                        Text(
                          'Select Service',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        Card(
                          color: ColorApp.greyColor,
                          child: ListTile(
                            enabled: true,
                            title: Text(
                              selectedService.name,
                            ),
                            subtitle: selectedService.duration == null
                                ? Text(
                                    'Duration',
                                  )
                                : Text('${selectedService.duration} minutes'),
                            dense: true,
                            trailing: Icon(CupertinoIcons.right_chevron),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20.0),
                            onTap: () {
                              showCupertinoModalPopup(
                                semanticsDismissible: true,
                                context: context,
                                builder: (context) {
                                  return FutureBuilder(
                                    future: barberController
                                        .getBarberDetails(widget.barber.sId),
                                    builder: (context, snapshot) {
                                      if (snapshot.data == null) {
                                        return Container();
                                      } else {
                                        BarberDetails barberDetails =
                                            snapshot.data;
                                        barberDetails.serviceId
                                            .insert(0, selectedService);
                                        List<ServiceId> service =
                                            barberDetails.serviceId;
                                        return Container(
                                          height: 300,
                                          color: Colors.white,
                                          child: CupertinoPicker(
                                            children: <Widget>[
                                              for (int i = 0;
                                                  i < service.length;
                                                  i++)
                                                Text(
                                                  '${service[i].name}',
                                                ),
                                            ],
                                            itemExtent: 50,
                                            onSelectedItemChanged: (index) {
                                              setState(() {
                                                selectedService =
                                                    service[index];
                                                double duration =
                                                    service[index].duration /
                                                        60;
                                                totalPrice = duration *
                                                    widget.barber.rate;
                                              });
                                            },
                                          ),
                                        );
                                      }
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Time',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        Card(
                          color: ColorApp.greyColor,
                          child: ListTile(
                            enabled: true,
                            title: Text(
                              '${parseSelectedTime(selectedTime)}',
                            ),
                            dense: true,
                            trailing: Icon(CupertinoIcons.right_chevron),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20.0),
                            onTap: () {
                              showCupertinoModalPopup(
                                semanticsDismissible: true,
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: 300,
                                    child: CupertinoDatePicker(
                                      onDateTimeChanged: (time) {
                                        setState(() {
                                          selectedTime = time;
                                        });
                                      },
                                      initialDateTime: now,
                                      backgroundColor: Colors.white,
                                      minimumDate: now,
                                      maximumDate: maximumDate,
                                      mode: CupertinoDatePickerMode.time,
                                      use24hFormat: true,
                                      minuteInterval: 30,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 3 - 90,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 6 + 20,
                        width: MediaQuery.of(context).size.width / 3 - 20,
                        decoration: BoxDecoration(
                          color: ColorApp.greyColor,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Positioned(
                              child: FadeInImage.assetNetwork(
                                width: 220,
                                placeholder: 'assets/notavailableimage.png',
                                image: '${widget.barber.image}',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.barber.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            widget.barber.description,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 10.0),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height - 100,
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  color: ColorApp.primaryColor,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Total Price',
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.0,
                              ),
                            ),
                            Text(
                              '\$$totalPrice',
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
                        child: FutureBuilder(
                            future: loginController.checkAuth(),
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                return CupertinoButton(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 40.0),
                                  child: Text('Book now'),
                                  disabledColor: Colors.grey,
                                  color: ColorApp.secondaryColor,
                                  pressedOpacity: 1,
                                  onPressed: () {
                                    alertDialogNotAuth(
                                        'Please Login or Register to Process Your Booking');
                                  },
                                );
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CupertinoButton(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 40.0),
                                  child: Text('Book now'),
                                  disabledColor: Colors.grey,
                                  color: ColorApp.secondaryColor,
                                  pressedOpacity: 1,
                                  onPressed: () {},
                                );
                              } else {
                                return CupertinoButton(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 40.0),
                                  child: Text('Book now'),
                                  disabledColor: Colors.grey,
                                  color: ColorApp.secondaryColor,
                                  pressedOpacity: 1,
                                  onPressed: now.hour >= bookingClosed
                                      ? () async {
                                          alertDialog('We are closed... Sorry');
                                        }
                                      : () async {
                                          String serviceId =
                                              selectedService.sId;
                                          String bookDate =
                                              selectedTime.toString();
                                          String barberId = widget.barber.sId;
                                          ModelResponse response =
                                              await bookingController
                                                  .createBooking(serviceId,
                                                      bookDate, barberId);
                                          if (response.status == false) {
                                            alertDialog('${response.message}');
                                          } else {
                                            await showNotification(
                                                bookDate,
                                                widget.barber.name,
                                                selectedService.name);
                                            Navigator.pop(context);
                                          }
                                        },
                                );
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  alertDialogNotAuth(String message) {
    return showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: Text('$message'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'login')
                    .then((value) => setState(() {}));
              },
            )
          ],
        );
      },
    );
  }

  alertDialog(String message) {
    return showCupertinoDialog(
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
  }

  showNotification(String date, String barberName, String serviceName) async {
    DateTime parsedDate = DateTime.parse(date);
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Makassar'));
    // var actual = tz.TZDateTime.fromMillisecondsSinceEpoch(
    //     tz.local, parsedDate.millisecondsSinceEpoch);
    var five = tz.TZDateTime.now(tz.local).add(Duration(seconds: 5));
    var iOS = IOSNotificationDetails();
    var platform = new NotificationDetails(iOS: iOS);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Booking $serviceName at ${parseSelectedTime(parsedDate)}',
      'See your booking with $barberName',
      five,
      platform,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: null,
      payload: 'booking',
    );
  }

  String parseSelectedTime(DateTime dateTime) {
    DateFormat dateFormat = DateFormat('HH:mm');
    String date = dateFormat.format(dateTime);
    return date;
  }
}
