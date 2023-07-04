import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mamak/presentation/uiModel/newHome/calendar_item.dart';
import 'package:mamak/presentation/uiModel/newHome/week_item.dart';

class CalendarObjectDraggable {
  static List<WeekItem> items = [
    const WeekItem(id: 0, name: 'شنبه'),
    const WeekItem(id: 1, name: 'یکشنبه'),
    const WeekItem(id: 2, name: 'دوشنبه'),
    const WeekItem(id: 3, name: 'سه شنبه'),
    const WeekItem(id: 4, name: 'چهارشنبه'),
  ];

  static Map<WeekItem, CalendarItem> remindersItem = {
    const WeekItem(id: 0, name: 'شنبه'): CalendarItem(
      id: 0,
      name: '۶ روز ماده',
      assessment: 'ریاضی',
      date: '21',
      color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0),
    ),
    const WeekItem(id: 1, name: 'یکشنبه'): CalendarItem(
      id: 1,
      name: '۶ روز ماده',
      assessment: 'ارزیابی اول',
      date: '05',
      color: Colors.grey.shade200,
    ),
    WeekItem(id: 2, name: 'دوشنبه'): CalendarItem(
      id: 2,
      name: '۶ روز ماده',
      assessment: 'ارزیابی اول',
      date: '10',
      color: Colors.grey.shade200,
    ),
  };
}
