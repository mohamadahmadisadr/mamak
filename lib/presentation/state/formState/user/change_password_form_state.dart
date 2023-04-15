import 'package:mamak/data/body/user/changePassword/ChangePasswordBody.dart';

class ChangePasswordFormState {
  String mobile, currentPassword, password, confirmPassword;

  ChangePasswordFormState({
    this.mobile = '',
    this.currentPassword = '',
    this.password = '',
    this.confirmPassword = '',
  });

  ChangePasswordBody createBody(){
    return ChangePasswordBody(mobile: mobile, currentPassword: currentPassword, password: password, confirmPassword: confirmPassword);
  }
}
