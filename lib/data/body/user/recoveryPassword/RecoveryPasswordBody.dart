import 'package:json_annotation/json_annotation.dart';

part 'RecoveryPasswordBody.g.dart';

@JsonSerializable()
class RecoveryPasswordBody {
  final String mobile, password, confirmPassword, activationCode;

  const RecoveryPasswordBody({
    required this.mobile,
    required this.activationCode,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => _$RecoveryPasswordBodyToJson(this);

  RecoveryPasswordBody fromJson(Map<String, dynamic> json) =>
      _$RecoveryPasswordBodyFromJson(json);
}
