import 'package:mamak/data/body/user/verification/VerificationBody.dart';

class VerificationFormState {
  String mobile, activationCode;

  VerificationFormState({this.mobile = '', this.activationCode = ''});

  VerificationBody createBody() {
    return VerificationBody(mobile: mobile, activationCode: activationCode);
  }
}
