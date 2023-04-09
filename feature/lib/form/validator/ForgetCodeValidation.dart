import 'package:feature/form/validator/ValidationState.dart';
import 'package:feature/form/validator/Validator.dart';
class ForgetCodeValidation extends Validator {
  @override
  ValidationState validate(String data) {
    if (data.isEmpty) {
      return const ValidationState(
          state: false, msg: 'کد فراموشی را وارد کنید');
    }
    return const ValidationState(state: true);
  }
}
