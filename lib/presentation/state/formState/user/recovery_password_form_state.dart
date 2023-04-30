import 'package:mamak/data/body/user/recoveryPassword/RecoveryPasswordBody.dart';

class RecoveryPasswordFormState {
  String mobile, password, confirmPassword, activationCode;

  RecoveryPasswordFormState({
    this.mobile = '',
    this.activationCode = '',
    this.password = '',
    this.confirmPassword = '',
  });

  RecoveryPasswordBody createBody() {
    return RecoveryPasswordBody(
        mobile: mobile,
        password: password,
        confirmPassword: confirmPassword,
        activationCode: activationCode);
  }
}
