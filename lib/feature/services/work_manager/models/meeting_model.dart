import 'package:flutter/material.dart';

class Meeting {
  String eventName;
  String eventDescription;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;

  Meeting(this.eventName, this.eventDescription, this.from, this.to,
      this.background, this.isAllDay);
}