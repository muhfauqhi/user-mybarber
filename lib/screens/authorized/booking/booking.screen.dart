import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:user_frontend_mybarber/const/colors.const.dart';
import 'package:user_frontend_mybarber/const/custom.navigation.bar.dart';
import 'package:user_frontend_mybarber/controllers/booking.controller.dart';
import 'package:user_frontend_mybarber/models/booking.dart';
import 'package:user_frontend_mybarber/models/response.dart';

class BookingScreen extends StatefulWidget {
  BookingScreen({
    Key key,
  }) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final BookingController _bookingController = BookingController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  List<Booking> _booking = [];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CustomNavigationBar(heroTag: 'booking'),
      resizeToAvoidBottomInset: false,
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () {
          return _bookingController.getBooking().then(
            (value) {
              setState(() => _booking = value);
            },
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: 30.0),
          child: FutureBuilder(
            future: _bookingController.getBooking(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: CupertinoActivityIndicator());
              if (snapshot.data == null) {
                return Center(
                  child: Text(
                    'Currently no booking',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                );
              } else {
                _booking = snapshot.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Your Booking',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24.0,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _booking.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              dense: true,
                              onTap: () {
                                showModalBottomSheet(
                                  isDismissible: true,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return BookingDetails(
                                      booking: _booking[index],
                                    );
                                  },
                                );
                              },
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                    '${_booking[index].barber.image}'),
                                backgroundColor: ColorApp.primaryColor,
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '${_booking[index].barber.name}',
                                  ),
                                  Text(
                                    '${_booking[index].status}',
                                    style: TextStyle(
                                        color: statusColor(
                                            _booking[index].status)),
                                  ),
                                ],
                              ),
                              subtitle:
                                  Text(formatDate(_booking[index].createdAt)),
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
        ),
      ),
    );
  }

  Color statusColor(String status) {
    switch (status) {
      case 'Finished':
        return ColorApp.primaryColor;
      case 'Pending':
        return ColorApp.terraCotta;
      default:
        return ColorApp.secondaryColor;
    }
  }

  String formatDate(String createdAt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    DateFormat dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ');
    DateTime formatDate = dateFormat.parse(createdAt).add(Duration(hours: 8));
    final aDate = DateTime(formatDate.year, formatDate.month, formatDate.day);
    if (aDate == today) {
      String format = DateFormat('hh.mm a').format(formatDate);
      return 'Today, $format';
    }
    if (aDate == yesterday) {
      String format = DateFormat('hh.mm a').format(formatDate);
      return 'Today, $format';
    } else {
      String format = DateFormat.yMMMMEEEEd().format(formatDate);
      return format;
    }
  }
}

class BookingDetails extends StatefulWidget {
  const BookingDetails({
    Key key,
    @required this.booking,
  }) : super(key: key);

  final Booking booking;

  @override
  _BookingDetailsState createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  bool ratingUpdate = false;
  final BookingController bookingController = BookingController();
  int rating = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 30.0,
              horizontal: 30.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      NetworkImage('${widget.booking.barber.image}'),
                  backgroundColor: ColorApp.primaryColor,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(formatDate(widget.booking.createdAt)),
                    Text(
                      'Order B-${widget.booking.bookingId.toUpperCase()}',
                    ),
                    Text(
                      '${widget.booking.status}',
                      style:
                          TextStyle(color: statusColor(widget.booking.status)),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 40, child: Divider(thickness: 1.0)),
          if (widget.booking.rating == 0 && widget.booking.status == 'Finished')
            Rating(
              booking: widget.booking,
              onRatingUpdate: (value) {
                setState(() {
                  ratingUpdate = true;
                  rating = value.toInt();
                });
              },
            )
          else if (widget.booking.rating == 0 &&
              widget.booking.status == 'Finished')
            null
          else if (widget.booking.rating > 0 &&
              widget.booking.status == 'Finished')
            Rating(booking: widget.booking, ignoreGestures: true),
          if (ratingUpdate == true)
            CupertinoButton(
              color: ColorApp.seaGreenColor,
              child: Text('Done'),
              onPressed: () async {
                ModelResponse response = await bookingController
                    .updateBookingRating(widget.booking.sId, rating);
                if (response.status) Navigator.pop(context);
              },
            )
          else
            SizedBox(),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 30.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order details',
                      style: TextStyle(color: ColorApp.davysGreyColor),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Service',
                    ),
                    Text(
                      '${widget.booking.service[0].name}',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Barber',
                    ),
                    Text(
                      '${widget.booking.barber.name}',
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 30.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment details',
                      style: TextStyle(color: ColorApp.davysGreyColor),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Barber Rate',
                    ),
                    Text(
                      '\$ ${widget.booking.barber.rate}.0',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Duration',
                    ),
                    Text(
                      '${toHours(widget.booking.service[0].duration)} hour(s)',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 30.0,
                  horizontal: 30.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Price',
                    ),
                    Text(
                      '\$ ${totalPrice(widget.booking.barber.rate, toHours(widget.booking.service[0].duration))}',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color statusColor(String status) {
    switch (status) {
      case 'Finished':
        return ColorApp.primaryColor;
      case 'Pending':
        return ColorApp.terraCotta;
      default:
        return ColorApp.secondaryColor;
    }
  }

  double totalPrice(int rate, double duration) {
    return rate * duration;
  }

  double toHours(int minutes) {
    return minutes / 60;
  }

  String formatDate(String bookDate) {
    DateFormat dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ');
    DateTime formatDate = dateFormat.parse(bookDate).add(Duration(hours: 8));
    String format = DateFormat('EEEE, d LLL y, hh:mm a').format(formatDate);
    return format;
  }
}

class Rating extends StatelessWidget {
  const Rating({
    Key key,
    @required this.booking,
    this.ignoreGestures = false,
    this.onRatingUpdate,
  }) : super(key: key);

  final Booking booking;
  final bool ignoreGestures;
  final ValueChanged<double> onRatingUpdate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: RatingBar.builder(
            glow: false,
            ignoreGestures: ignoreGestures,
            initialRating: booking.rating.toDouble(),
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, index) {
              return Icon(
                Icons.star,
                color: Colors.amber,
              );
            },
            onRatingUpdate: onRatingUpdate,
          ),
        ),
        SizedBox(height: 40, child: Divider(thickness: 1.0))
      ],
    );
  }
}
