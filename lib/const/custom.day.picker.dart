import 'package:flutter/material.dart';
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

class CustomDayPicker extends StatefulWidget {
  final ValueChanged<int> onSelected;
  const CustomDayPicker({Key key, this.onSelected}) : super(key: key);
  @override
  _CustomDayPickerState createState() => _CustomDayPickerState();
}

class _CustomDayPickerState extends State<CustomDayPicker> {
  int _selectedDay = -1;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    _selectedDay = now.weekday - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      child: Column(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                for (int i = 0; i < day.length; i++)
                  Test(
                    selectedValue: (select) {
                      setState(() {
                        _selectedDay = i;
                        widget.onSelected(select);
                      });
                    },
                    selected: _selectedDay == i,
                    day: day[i],
                    color: _selectedDay == i
                        ? ColorApp.seaGreenColor
                        : Colors.white,
                    textColor: _selectedDay == i ? Colors.white : Colors.black,
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Test extends StatelessWidget {
  final Map<String, Object> day;
  final ValueChanged<int> selectedValue;
  final Color color;
  final Color textColor;
  final bool selected;

  Test({
    Key key,
    @required this.day,
    this.selectedValue,
    this.color = Colors.white,
    this.textColor = Colors.black,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    return GestureDetector(
      onTap: () {
        selectedValue(day['num']);
      },
      child: Container(
        height: 80,
        width: 50,
        margin: EdgeInsets.symmetric(),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Builder(
          builder: (context) {
            if (now.weekday == day['num']) {
              if (selected) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    dayText(),
                    Text(
                      'Today',
                      style: TextStyle(
                        fontSize: 12.0,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.normal,
                        color: textColor,
                      ),
                    ),
                  ],
                );
              } else {
                return dayText();
              }
            } else {
              return dayText();
            }
          },
        ),
      ),
    );
  }

  Text dayText() {
    return Text(
      '${day['simple']}',
      style: TextStyle(
        fontSize: 18,
        letterSpacing: 1.0,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
    );
  }
}
