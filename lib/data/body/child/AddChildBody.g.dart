// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddChildBody.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddChildBody _$AddChildBodyFromJson(Map<String, dynamic> json) => AddChildBody(
      childFirstName: json['childFirstName'] as String,
      childLastName: json['childLastName'] as String,
      birtDate: json['birtDate'] as String,
      mobileNumber: json['mobileNumber'] as String,
      childPicture: json['childPicture'] == null
          ? null
          : FileDataBody.fromJson(json['childPicture'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddChildBodyToJson(AddChildBody instance) =>
    <String, dynamic>{
      'childFirstName': instance.childFirstName,
      'childLastName': instance.childLastName,
      'birtDate': instance.birtDate,
      'mobileNumber': instance.mobileNumber,
      if (instance.childPicture != null)
        'childPicture': instance.childPicture?.toJson(),
    };
