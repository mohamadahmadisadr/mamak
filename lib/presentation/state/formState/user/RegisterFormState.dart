class RegisterFormState {
  RegisterFormState({
    this.mobile = '',
    this.nationalCode = '',
    this.referredCode,
  });

  String nationalCode, mobile;
  String? referredCode;
}
