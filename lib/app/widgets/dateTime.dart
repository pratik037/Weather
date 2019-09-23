import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeBar extends StatelessWidget {
  DateTime current = DateTime.now();
  List<String> months = [
    'JANUARY',
    'FEBRUARY',
    'MARCH',
    'APRIL',
    'MAY',
    'JUNE',
    'JULY',
    'AUGUST',
    'SEPTEMBER',
    'OCTOBER',
    'NOVEMBER',
    'DECEMBER'
  ];
  List<String> day = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(4),
          child: Text(
            '${day[current.weekday - 1]} | ${months[current.month - 1]} ${current.day}, ${current.year} |  ${DateFormat("hh:mm a").format(current)}',
            style: TextStyle(fontSize: 22, color: Colors.white70),
          ),
        ),
      ],
    );
  }
}
