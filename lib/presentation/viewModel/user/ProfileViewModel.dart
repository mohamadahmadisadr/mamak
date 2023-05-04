import 'dart:convert';
import 'dart:typed_data';

import 'package:core/imagePicker/ImageFileModel.dart';
import 'package:core/imagePicker/MyImagePicker.dart';
import 'package:mamak/data/body/user/profile/FileDataBody.dart';
import 'package:mamak/data/body/user/profile/UploadUserAvatarBody.dart';
import 'package:mamak/data/serializer/user/GetUserProfileResponse.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/user/GetUserProfileUseCase.dart';
import 'package:mamak/useCase/user/SetUserAvatarUseCase.dart';

class ProfileViewModel extends BaseViewModel {
  AppState uploadState = AppState.idle;
  AppState userState = AppState.idle;
  ImageFileModel? selectedImage;
  final MyImagePicker _myImagePicker = GetIt.I.get();
  final NavigationServiceImpl _navigationServiceImpl =
      GetIt.I.get<NavigationServiceImpl>();

  ProfileViewModel(super.initialState) {
    getUseData();
  }

  void getImage() async {
    var avatarId = selectedImage?.Id ?? '00000000-0000-0000-0000-000000000000';
    selectedImage = await _myImagePicker.pickImage();
    selectedImage?.Id = avatarId;
    if (!uploadState.isLoading && selectedImage != null) {
      SetUserAvatarUseCase().invoke(
        MyFlow(
          flow: (appState) {
            if (appState.isFailed) {
              messageService
                  .showSnackBar(appState.getErrorModel?.message ?? '');
            }
            uploadState = appState;
            refresh();
          },
        ),
        data: selectedImage!.createBody(),
      );
    }
  }

  void refresh() {
    updateScreen(time: DateTime.now().microsecondsSinceEpoch.toDouble());
  }

  void getUseData() {
    GetUserProfileUseCase().invoke(MyFlow(flow: (appState) {
      if (appState.isSuccess && appState.getData is GetUserProfileResponse) {
        GetUserProfileResponse res = appState.getData;
        if (res.userAvatar?.content != null) {
          selectedImage = ImageFileModel(
              name: res.userAvatar?.fileName ?? '',
              mimType: res.userAvatar?.mimeType ?? '',
              content: res.userAvatar?.content ?? '',
              Id: res.userAvatar?.id ?? '00000000-0000-0000-0000-000000000000');
        }
      }
      userState = appState;
      refresh();
    }));
  }

  void pickImage() {
    getImage();
  }

  void gotoAddChildPage() {
    _navigationServiceImpl.navigateTo(AppRoute.addChild);
  }
}

extension ImageFileModelExtension on ImageFileModel {
  UploadUserAvatarBody createBody() {
    return UploadUserAvatarBody(
      mobileNumber: '',
      fileData: FileDataBody(
          content: content, mimeType: mimType, fileName: name, Id: Id),
    );
  }

  FileDataBody createFileDataBody() =>
      FileDataBody(content: content, mimeType: mimType, fileName: name, Id: Id);

  Uint8List getFileFormBase64() {
    return base64Decode(content);
  }
}
