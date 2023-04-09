class LoginFormState {
  LoginFormState({
    this.mobile = '',
    this.mobileError,
    this.password = '',
    this.passwordError,
  });

  String mobile;
  String? mobileError;
  String password;
  String? passwordError;
}
