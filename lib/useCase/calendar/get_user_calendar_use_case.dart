import 'package:mamak/config/apiRoute/calendar/calendar_urls.dart';
import 'package:mamak/data/serializer/calendar/UserCalendarResponse.dart';
import 'package:mamak/useCase/BaseUseCase.dart';

class GetUserCalendarUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    assert(data != null && data is int);
    try {
      flow.emitLoading();
      var uri = createUri(
          path: CalendarUrls.getUserChildCalendar, body: {'userChildId': data.toString()});
      print('path is ${uri.path} query is ${uri.query} params is ${uri.data?.parameters}');
      var response = await apiServiceImpl.get(uri);
      if (response.isSuccessful) {
        var result = response.result;
        if (result.isSuccessFull) {
          flow.emitData(userCalendarResponseFromJson(result.result));
        } else {
          if(result.resultCode == 204){
            flow.emitData(204);
          }else{
            flow.throwMessage(result.concatErrorMessages);
          }

        }
      } else {
        flow.throwError(response);
      }
    } catch (e) {
      Logger.e(e);
      flow.throwCatch();
    }
  }
}
