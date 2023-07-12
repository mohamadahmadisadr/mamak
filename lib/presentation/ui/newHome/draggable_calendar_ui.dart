import 'package:flutter/material.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:mamak/data/serializer/calendar/UserCalendarResponse.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/ui/newHome/CalendarItemUi.dart';
import 'package:mamak/presentation/ui/newHome/week_item_ui.dart';
import 'package:mamak/presentation/uiModel/newHome/calendar_object_draggable.dart';

class DraggableCalendarUi extends StatefulWidget {
  DraggableCalendarUi({
    Key? key,
    required this.items,
    required this.onClick,
  }) : super(key: key);
  final List<CalendarItems> items;
  final days = CalendarObjectDraggable.items;

  //this boolean means -> if false the root list should be empty else should send to server;
  final Function(bool) onClick;

  @override
  State<DraggableCalendarUi> createState() => _DraggableCalendarUiState();
}

class _DraggableCalendarUiState extends State<DraggableCalendarUi> {
  var enabled = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.days.length * 50,
          child: Padding(
            padding: 8.dpeh,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: widget.days.map((item) {
                    return WeekItemUi(item: item);
                  }).toList(),
                ),
                8.dph,
                Expanded(
                  child: ReorderableListView(
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        final item = widget.items.removeAt(oldIndex);
                        widget.items.insert(newIndex, item);
                      });
                    },
                    primary: true,
                    buildDefaultDragHandles: false,
                    children: widget.items.map((item) {
                      return ReorderableDragStartListener(
                        key: Key(item.dayOfWeek.toString()),
                        index: widget.items.indexOf(item),
                        enabled: enabled,
                        child: ShakeWidget(
                          shakeConstant: ShakeLittleConstant2(),
                          autoPlay: enabled,
                          enableWebMouseHover: false,
                          child: SizedBox(
                          height: 50,
                            child: CalendarItemUi(
                              item: item,
                              mode: CalendarMode.calendar,
                              index: widget.items.indexOf(item),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
        4.dpv,
        Padding(
          padding: 16.dpeh,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: 16.bRadius,
                  border: Border.all(color: Colors.black),
                ),
                child: TextButton.icon(
                  icon: const Icon(Icons.add_circle),
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontFamily: 'dana',
                    ),
                    iconColor: Colors.black,
                    surfaceTintColor: Colors.grey,
                  ),
                  onPressed: () {
                    widget.onClick.call(enabled);
                    setState(() {
                      enabled = !enabled;
                    });
                  },
                  label: Text(
                    enabled ? 'اعمال تغییرات' : 'شخصی سازی تقویم',
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
