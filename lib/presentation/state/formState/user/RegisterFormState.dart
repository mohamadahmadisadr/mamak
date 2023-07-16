import 'package:mamak/data/body/user/register/SignUpBody.dart';

class RegisterFormState {
  String firstName, lastName, mobile, password, confirmPassword;
  String? firstNameError,
      lastNameError,
      mobileError,
      passwordError,
      confirmPasswordError,
      emailError,
      termsError;


  RegisterFormState(
      {this.firstName = '',
      this.firstNameError,
      this.lastName = '',
      this.lastNameError,
      this.mobile = '',
      this.mobileError,
      this.password = '',
      this.passwordError,
      this.confirmPassword = '',
      this.confirmPasswordError,
      this.termsError});

  SignUpBody getBody() {
    return SignUpBody(
        firstName: firstName,
        lastName: lastName,
        mobile: mobile,
        password: password,
        confirmPassword: confirmPassword,
    );
  }
}
