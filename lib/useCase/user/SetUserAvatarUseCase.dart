import 'package:mamak/config/apiRoute/user/UserUrls.dart';
import 'package:mamak/data/body/user/profile/UploadUserAvatarBody.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/BaseUseCase.dart';

class SetUserAvatarUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    assert(data != null && data is UploadUserAvatarBody);

    try {
      (data as UploadUserAvatarBody).mobileNumber = await GetIt.I
          .get<LocalSessionImpl>()
          .getData(UserSessionConst.mobile);
      print(data.fileData.mimeType);
      flow.emitLoading();
      var uri = createUri(path: UserUrls.setUserAvatar);
      var response = await apiServiceImpl.post2(uri, jsonEncode(data));

      if (response.isSuccessful) {
        var result = response.result;
        if (result.isSuccessFull) {
          flow.emitData('');
        } else {
          flow.throwMessage(result.concatErrorMessages);
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
