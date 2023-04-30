import 'package:feature/form/validator/ValidationState.dart';
import 'package:feature/form/validator/Validator.dart';

class EmailValidator extends Validator {
  @override
  ValidationState validate(String data) {
    if (data.isEmpty) {
      return const ValidationState(state: false, msg: 'ایمیل را وارد کنید');
    }
    if (!emailValid(data)) {
      return const ValidationState(
          state: false, msg: 'ایمیل وارد شده صحیح نیست');
    }

    return const ValidationState(state: true);
  }

  bool emailValid(String email) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}
