import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:user_frontend_mybarber/const/colors.const.dart';

final day = [
  {
    'num': 1,
    'default': 'Monday',
    'simple': 'Mon',
  },
  {
    'num': 2,
    'default': 'Tuesday',
    'simple': 'Tue',
  },
  {
    'num': 3,
    'default': 'Wednesday',
    'simple': 'Wed',
  },
  {
    'num': 4,
    'default': 'Thursday',
    'simple': 'Thu',
  },
  {
    'num': 5,
    'default': 'Friday',
    'simple': 'Fri',
  },
  {
    'num': 6,
    'default': 'Saturday',
    'simple': 'Sat',
  },
  {
    'num': 7,
    'default': 'Sunday',
    'simple': 'Sun',
  },
];

final month = [
  {
    'num': 1,
    'default': 'January',
    'simple': 'Jan',
  },
  {
    'num': 2,
    'default': 'February',
    'simple': 'Feb',
  },
  {
    'num': 3,
    'default': 'March',
    'simple': 'Mar',
  },
  {
    'num': 4,
    'default': 'April',
    'simple': 'Apr',
  },
  {
    'num': 5,
    'default': 'May',
    'simple': 'May',
  },
  {
    'num': 6,
    'default': 'June',
    'simple': 'Jun',
  },
  {
    'num': 7,
    'default': 'July',
    'simple': 'Jul',
  },
  {
    'num': 8,
    'default': 'August',
    'simple': 'Aug',
  },
  {
    'num': 9,
    'default': 'September',
    'simple': 'Sep',
  },
  {
    'num': 10,
    'default': 'October',
    'simple': 'Oct',
  },
  {
    'num': 11,
    'default': 'November',
    'simple': 'Nov',
  },
  {
    'num': 12,
    'default': 'December',
    'simple': 'Dec',
  },
];

class CustomDatePicker extends StatefulWidget {
  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  putDate(DateTime date) {
    List<MyDate> myDate = [];
    for (int i = 0; i < 30 + 1; i++) {
      DateTime temp = date.add(Duration(days: i));
      myDate.add(MyDate(temp.day, temp.weekday, temp.month, temp.year));
    }
    return myDate;
  }

  putMonth(DateTime date) {
    List<MyDate> myDate = [];
    for (int i = 0; i < 12; i++) {
      DateTime temp = DateTime(date.year, date.month + i, 1);
      myDate.add(MyDate(temp.day, temp.weekday, temp.month, temp.year));
    }
    return myDate;
  }

  @override
  void initState() {
    super.initState();
    myDate = putDate(now);
    myMonth = putMonth(now);
  }

  int _selectedDay = 0;
  int _selectedMonth = 0;

  List<MyDate> myDate;
  DateTime now = DateTime.now();
  List<MyDate> myMonth;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                for (int i = 0; i < 12; i++)
                  BoxMonth(
                    date: myMonth[i],
                    color: _selectedMonth == i
                        ? ColorApp.secondaryColor
                        : ColorApp.greyColor,
                    textColor:
                        _selectedMonth == i ? Colors.white : Colors.black,
                    selectedValue: (date) {
                      if (date.month != now.month) {
                        setState(() {
                          _selectedDay = -1;
                          myDate.clear();
                          myDate = putDate(
                            DateTime(date.year, date.month, date.date),
                          );
                        });
                      }
                      if (date.month == now.month) {
                        setState(() {
                          _selectedDay = date.date - 1;
                          myDate.clear();
                          myDate = putDate(now);
                        });
                      }
                      setState(() {
                        _selectedMonth = i;
                      });
                    },
                  ),
              ],
            ),
          ),
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i < myDate.length; i++)
                    BoxDate(
                      textColor:
                          _selectedDay == i ? Colors.white : Colors.black,
                      color: _selectedDay == i
                          ? ColorApp.indigoDyeColor
                          : ColorApp.greyColor,
                      date: myDate[i],
                      selectedValue: (date) {
                        if (date.month != now.month) {
                          setState(() {
                            _selectedMonth = date.month;
                          });
                        }
                        setState(() {
                          _selectedDay = i;
                          print(date);
                        });
                      },
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BoxMonth extends StatelessWidget {
  final MyDate date;
  final ValueChanged<MyDate> selectedValue;
  final Color color;
  final Color textColor;
  const BoxMonth({
    Key key,
    this.date,
    this.selectedValue,
    this.color = Colors.white,
    this.textColor,
  }) : super(key: key);

  checkMonth(int months, String format) {
    for (int i = 0; i < month.length; i++) {
      if (month[i]['num'] == months) {
        return month[i][format];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String month = checkMonth(date.month, 'default');
    return GestureDetector(
      onTap: () {
        selectedValue(date);
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        height: 40,
        width: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(5.0),
            bottom: Radius.circular(5.0),
          ),
        ),
        child: Center(
          child: Text(
            month,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}

class MyDate {
  final int date;
  final int weekDay;
  final int month;
  final int year;

  MyDate(this.date, this.weekDay, this.month, this.year);
}

class BoxDate extends StatelessWidget {
  final MyDate date;
  final ValueChanged<DateTime> selectedValue;
  final Color color;
  final Color textColor;
  const BoxDate({
    Key key,
    this.date,
    this.selectedValue,
    this.color = Colors.white,
    this.textColor = Colors.black,
  }) : super(key: key);

  checkDay(int weekDay, String format) {
    for (int i = 0; i < day.length; i++) {
      if (day[i]['num'] == weekDay) {
        return day[i][format];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String weekday = checkDay(date.weekDay, 'simple');
    return GestureDetector(
      onTap: () {
        DateTime dateTime = DateTime(date.year, date.month, date.date);
        selectedValue(dateTime);
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        height: 120,
        width: 80,
        decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.5),
          //     spreadRadius: 5.0,
          //     blurRadius: 7,
          //     offset: Offset(0, 3),
          //   ),
          // ],
          color: color,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
            bottom: Radius.circular(20.0),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                date.date.toString(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              Text(
                weekday,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
