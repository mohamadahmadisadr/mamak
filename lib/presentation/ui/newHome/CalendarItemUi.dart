import 'package:core/color/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/data/serializer/calendar/UserCalendarResponse.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:shamsi_date/shamsi_date.dart';

class CalendarItemUi extends StatelessWidget {
  const CalendarItemUi({
    Key? key,
    required this.item,
    required this.mode,
    required this.index,
    this.selectedIndex,
  }) : super(key: key);
  final CalendarItems item;
  final CalendarMode mode;
  final int index;
  final int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      height: 45,
      padding: 4.dpe,
      margin: 2.dpe,
      decoration: BoxDecoration(
        borderRadius: 12.bRadius,
        border: Border.all(
            color: mode == CalendarMode.calendar
                ? Colors.grey
                : Colors.grey.shade400,
            width: 1.0),
        color: mode == CalendarMode.calendar
            ? item.parentCategory?.colorNumber?.toColor()
            : Colors.grey.shade200,
      ),
      child: Padding(
        padding: 4.dpeh,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: 4.dpeh,
              child: Text(
                  mode == CalendarMode.reminder
                      ? item.nextAssessmentDate != null
                          ? getDifferent(item.nextAssessmentDate!)
                          : ''
                      : item.parentCategory?.title ?? '',
                  style: context.textTheme.titleMedium),
            ),
            if (mode == CalendarMode.reminder)
              Text(item.parentCategory?.title ?? '',
                  style: context.textTheme.titleSmall),
            if (item.nextAssessmentDate != null)
              Container(
                alignment: Alignment.center,
                padding: 4.dpe,
                margin: 4.dpe,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: 8.bRadius,
                  color: Colors.white,
                ),
                child: Text(getPersianDayWithMonth(item.nextAssessmentDate!)),
              )
          ],
        ),
      ),
    );
  }

  getDifferent(DateTime nextAssessmentDate) {
    var days = nextAssessmentDate.difference(DateTime.now()).inDays;
    var hours = nextAssessmentDate.difference(DateTime.now()).inHours;
    if (days == 0) {
      print(hours);
    }

    if (hours > 0 && hours < 12) return '$hours ساعت مانده';
    return days == 0 ? 'امروز' : '$days روز مانده';
  }

  String getPersianDayWithMonth(DateTime nextAssessmentDate) {
    var f = nextAssessmentDate.toJalali().formatter;
    return '${f.d} ${f.mN}';
  }
}

enum CalendarMode {
  calendar,
  reminder;
}
