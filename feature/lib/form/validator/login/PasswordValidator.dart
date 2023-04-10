import 'package:feature/form/validator/ValidationState.dart';
import 'package:feature/form/validator/Validator.dart';

class PasswordValidator extends Validator {
  final bool rePassword;

  PasswordValidator(this.rePassword);

  @override
  ValidationState validate(String data) {
    if (data.isEmpty) {
      return ValidationState(
          state: false,
          msg: rePassword
              ? 'تکرار گذرواژه  خود را وارد کنید'
              : 'گذرواژه خود را وارد کنید');
    }
    return const ValidationState(state: true);
  }
}
