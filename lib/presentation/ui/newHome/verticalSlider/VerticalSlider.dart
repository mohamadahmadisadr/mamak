import 'package:core/card_widget/card_stack_widget.dart';
import 'package:flutter/material.dart';
import 'package:mamak/data/serializer/calendar/UserCalendarResponse.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/ui/newHome/CalendarItemUi.dart';

class VerticalSliderUi extends StatefulWidget {
  const VerticalSliderUi({
    Key? key,
    required this.items,
    required this.todayClicked,
  }) : super(key: key);
  final List<CalendarItems> items;
  final Function(int) todayClicked;

  @override
  State<VerticalSliderUi> createState() => _VerticalSliderUiState();
}

class _VerticalSliderUiState extends State<VerticalSliderUi> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<CalendarItems> list = List.from(widget.items);
    list.removeWhere((element) =>
        element.nextAssessmentDate == null &&
        element.nextAssessmentDate!.isAfter(DateTime.now()));
    list.sort((a, b) => a.nextAssessmentDate!.compareTo(b.nextAssessmentDate!));

    return SizedBox(
      height: 170,
      child: CardStackWidget(
        cardList: list.map((item) {
          return CardModel(
          radius: 16.radius,
            index: list.indexOf(item),
            child: Opacity(
              opacity: .7,
              child: CalendarItemUi(
                item: item,
                mode: CalendarMode.reminder,
                index: list.indexOf(item),
                selectedIndex: selectedIndex,
              ),
            ),
            border: Border.all(color: Colors.transparent, width: 0.0),
            shadowBlurRadius: 0.0,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.orange,
          );
        }).toList(),
        opacityChangeOnDrag: true,
        swipeOrientation: CardOrientation.both,
        cardDismissOrientation: CardOrientation.both,
        positionFactor: 1.2,
        scaleFactor: 0.9,
        alignment: Alignment.center,
        reverseOrder: true,
        animateCardScale: true,
        dismissedCardDuration: const Duration(milliseconds: 100),
        onChangeIndex: (data) {
          if (selectedIndex != data) {
            selectedIndex = data;
            // setState(() {});
          }
        },
        onCardTap: (cardModel) {
          if (cardModel.index == 0) {
            if (isToday(list.elementAt(0).nextAssessmentDate!)) {
              widget.todayClicked.call(0);
            }
          }
        },
      ),
    );
  }

  bool isToday(DateTime someDate) {
    var today = DateTime.now();
    return someDate.day == today.day &&
        someDate.month == today.month &&
        someDate.year == today.year;
  }
}
