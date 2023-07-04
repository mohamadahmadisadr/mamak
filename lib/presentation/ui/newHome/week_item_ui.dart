import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/data/serializer/calendar/UserCalendarResponse.dart';
import 'package:mamak/presentation/uiModel/newHome/week_item.dart';
import 'package:shamsi_date/shamsi_date.dart';

class WeekItemUi extends StatelessWidget {
  const WeekItemUi({Key? key, required this.item}) : super(key: key);
  final WeekItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      height: 50,
      child: Text(item.name,
          style: context.textTheme.titleMedium, textAlign: TextAlign.start),
    );
  }
}
