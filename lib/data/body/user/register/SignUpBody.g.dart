// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SignUpBody.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpBody _$SignUpBodyFromJson(Map<String, dynamic> json) => SignUpBody(
      firstName: json['firstName'],
      lastName: json['lastName'],
      mobile: json['mobile'],
      password: json['password'],
      confirmPassword: json['confirmPassword'],
      email: json['email'],
    );

Map<String, dynamic> _$SignUpBodyToJson(SignUpBody instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'mobile': instance.mobile,
      'email': instance.email,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
    };
