// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChangePasswordBody.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordBody _$ChangePasswordBodyFromJson(Map<String, dynamic> json) =>
    ChangePasswordBody(
      mobile: json['mobile'] as String,
      currentPassword: json['currentPassword'] as String,
      password: json['password'] as String,
      confirmPassword: json['confirmPassword'] as String,
    );

Map<String, dynamic> _$ChangePasswordBodyToJson(ChangePasswordBody instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
      'currentPassword': instance.currentPassword,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
    };
