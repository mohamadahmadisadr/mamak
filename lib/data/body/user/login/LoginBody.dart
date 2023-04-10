import 'package:json_annotation/json_annotation.dart';

part 'LoginBody.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginBody {
  LoginBody({
    required this.mobile,
    required this.password,
  });

  LoginBody fromJson(Map<String, dynamic> json) => _$LoginBodyFromJson(json);
  Map<String, dynamic> toJson() => _$LoginBodyToJson(this);

  final String mobile, password;
}
