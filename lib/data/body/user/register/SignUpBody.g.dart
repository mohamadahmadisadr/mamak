// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SignUpBody.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpBody _$SignUpBodyFromJson(Map<String, dynamic> json) => SignUpBody(
      firstName: json['firstName'],
      lastName: json['lastName'],
      mobile: json['mobile'] as String?,
      ReCaptchaToken: json['ReCaptchaToken'] as String?,
      password: json['password'],
      confirmPassword: json['confirmPassword'],
      email: json['email'],
    );

Map<String, dynamic> _$SignUpBodyToJson(SignUpBody instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('email', instance.email);
  writeNotNull('password', instance.password);
  writeNotNull('confirmPassword', instance.confirmPassword);
  writeNotNull('mobile', instance.mobile);
  writeNotNull('ReCaptchaToken', instance.ReCaptchaToken);
  return val;
}
