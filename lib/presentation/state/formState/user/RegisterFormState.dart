class RegisterFormState {
  String firstName, lastName, mobile, password, rePassword;
  String? firstNameError,
      lastNameError,
      mobileError,
      passwordError,
      rePasswordError,
      subscribeIdError,
      termsError;

  int subscribeId;
  bool terms;

  RegisterFormState(
      {this.firstName = '',
      this.firstNameError,
      this.lastName = '',
      this.lastNameError,
      this.mobile = '',
      this.mobileError,
      this.password = '',
      this.passwordError,
      this.rePassword = '',
      this.rePasswordError,
      this.subscribeId = 0,
      this.subscribeIdError,
      this.terms = false,
      this.termsError});
}
