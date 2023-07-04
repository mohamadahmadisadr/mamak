import 'package:core/Notification/MyNotification.dart';
import 'package:core/Notification/MyNotificationListener.dart';
import 'package:core/imagePicker/ImageFileModel.dart';
import 'package:core/imagePicker/MyImagePicker.dart';
import 'package:mamak/data/body/child/EditChildDataBody.dart';
import 'package:mamak/data/serializer/child/ChildsResponse.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/presentation/viewModel/user/ProfileViewModel.dart';
import 'package:mamak/useCase/child/EditChildDataUseCase.dart';

class EditChildDataViewModel extends BaseViewModel
    implements MyNotificationListener {
  final MyNotification _notification = GetIt.I.get();
  AppState uploadState = AppState.idle;
  ChildsItem? selectedChild;

  final MyImagePicker _myImagePicker = GetIt.I.get();
  ImageFileModel? selectedImage;

  EditChildDataViewModel(super.initialState) {
    _notification.subscribeListener(this);
  }

  void getImage() async {
    var avatarId = selectedImage?.Id ?? '00000000-0000-0000-0000-000000000000';
    selectedImage = await _myImagePicker.pickImage();
    selectedImage?.Id = avatarId;
    refresh();
    if (!uploadState.isLoading &&
        selectedImage != null &&
        selectedChild != null) {
      EditChildDataUseCase().invoke(MyFlow(flow: (appState) {
        uploadState = appState;
        refresh();
      }), data: selectedChild!.createChildDataBody(selectedImage!));
    }
  }

  void refresh() {
    updateScreen(time: DateTime.now().microsecondsSinceEpoch.toDouble());
  }

  void pickImage() {
    getImage();
  }

  void changeSelectedChild(ChildsItem children) {
    selectedChild = children;
    selectedImage = ImageFileModel(
      name: children.childPicture?.fileName ?? '',
      mimType: children.childPicture?.mimeType ?? '',
      content: children.childPicture?.content ?? '',
      Id: children.childPicture?.id ?? '00000000-0000-0000-0000-000000000000',
    );
    refresh();
  }

  @override
  void onReceiveData(data) {
    if (data != null) {
      if (data is ChildsItem) {
        selectedChild = data;
      }
    }
  }

  @override
  String tag() {
    return 'EditChildDataViewModel';
  }

  @override
  Future<void> close() {
    _notification.removeSubscribe(this);
    return super.close();
  }
}

extension ChildrenExtension on ChildsItem {
  EditChildDataBody createChildDataBody(ImageFileModel selectedImage) {
    return EditChildDataBody(
        childFirstName: childFirstName ?? '',
        childLastName: childLastName ?? '',
        mobileNumber: '',
        childPictureId: selectedImage.Id,
        childPicture: selectedImage.createFileDataBody());
  }
}
