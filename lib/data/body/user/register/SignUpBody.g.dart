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
      rePassword: json['rePassword'],
      subscribeId: json['subscribeId'] as int,
      terms: json['terms'] as bool,
    );

Map<String, dynamic> _$SignUpBodyToJson(SignUpBody instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'mobile': instance.mobile,
      'password': instance.password,
      'rePassword': instance.rePassword,
      'subscribeId': instance.subscribeId,
      'terms': instance.terms,
    };
