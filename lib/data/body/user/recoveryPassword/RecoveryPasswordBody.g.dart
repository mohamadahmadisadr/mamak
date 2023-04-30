// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RecoveryPasswordBody.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecoveryPasswordBody _$RecoveryPasswordBodyFromJson(
        Map<String, dynamic> json) =>
    RecoveryPasswordBody(
      mobile: json['mobile'] as String,
      activationCode: json['activationCode'] as String,
      password: json['password'] as String,
      confirmPassword: json['confirmPassword'] as String,
    );

Map<String, dynamic> _$RecoveryPasswordBodyToJson(
        RecoveryPasswordBody instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'activationCode': instance.activationCode,
    };
