import 'package:json_annotation/json_annotation.dart';

part 'ChangePasswordBody.g.dart';

@JsonSerializable()
class ChangePasswordBody {
  final String mobile, currentPassword, password, confirmPassword;

  const ChangePasswordBody({
    required this.mobile,
    required this.currentPassword,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => _$ChangePasswordBodyToJson(this);

  ChangePasswordBody fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordBodyFromJson(json);
}
