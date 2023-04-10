import 'package:feature/form/validator/ValidationState.dart';
import 'package:feature/form/validator/Validator.dart';

class LastNameValidator extends Validator{
  @override
  ValidationState validate(String data) {
    if (data.isEmpty) {
      return const ValidationState(
          state: false, msg: 'نام خانوادگی را وارد کنید');
    }
    return const ValidationState(state: true);
  }

}