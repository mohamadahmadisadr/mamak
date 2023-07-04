import 'package:flutter/material.dart';
import 'package:mamak/data/serializer/calendar/UserCalendarResponse.dart';
import 'package:mamak/presentation/state/app_state.dart';
import 'package:mamak/presentation/ui/main/ConditionalUI.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/ui/newHome/draggable_calendar_ui.dart';
import 'package:mamak/presentation/ui/newHome/verticalSlider/VerticalSlider.dart';
import 'package:mamak/presentation/viewModel/calendar/calendar_viewModel.dart';

class HomeCalendarUi extends StatefulWidget {
  const HomeCalendarUi({
    Key? key,
    required this.userChildId,
  }) : super(key: key);
  final int userChildId;

  @override
  State<HomeCalendarUi> createState() => _HomeCalendarUiState();
}

class _HomeCalendarUiState extends State<HomeCalendarUi> {
  late CalendarViewModel viewModel;

  @override
  void initState() {
    viewModel = CalendarViewModel(AppState.idle);
    viewModel.setUserChildId(widget.userChildId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => viewModel,
      builder: (bloc, state) {
        return ConditionalUI<UserCalendarResponse>(
          state: bloc.calendarState,
          onSuccess: (data) {
            data.calendarItems?.sort((a, b) =>
                a.dayOfWeek!.compareTo(b.dayOfWeek!));
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                4.dpv,
                DraggableCalendarUi(
                  items: data.calendarItems ?? [],
                  onClick: bloc.onSubmitClick,
                ),
                4.dpv,
                VerticalSliderUi(items: data.calendarItems ?? []),
              ],
            );
          },
        );
      },
    );
  }
}
