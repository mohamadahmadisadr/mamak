import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/calendar/get_default_calendar_use_case.dart';

class DefaultCalendarViewModel extends BaseViewModel {
  DefaultCalendarViewModel(super.initialState){
    getDefaultCalendar();
  }

  getDefaultCalendar() {
    GetDefaultCalendarUseCase().invoke(mainFlow);
  }
}
