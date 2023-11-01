import 'package:flutter/material.dart';
import 'package:mamak/data/body/calendar/home_calendar.dart';
import 'package:mamak/data/serializer/child/ChildsResponse.dart';

class WeeklyPlanSheet extends StatelessWidget {
  final ChildsItem childsItem;

  const WeeklyPlanSheet({super.key, required this.childsItem});

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        onClosing: () {},
        builder: (context) {
          return HomeCalendarUi(selectedChild: childsItem);
        });
  }
}
