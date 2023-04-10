import 'package:json_annotation/json_annotation.dart';

part 'SignUpBody.g.dart';

@JsonSerializable(explicitToJson: true)
class SignUpBody {
  final firstName, lastName, mobile, password, rePassword;
  final int subscribeId;
  final bool terms;

  const SignUpBody({
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.password,
    required this.rePassword,
    required this.subscribeId,
    required this.terms,
  });

  SignUpBody fromJson(Map<String, dynamic> json) => _$SignUpBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpBodyToJson(this);

// "isSuccess": true,
// "statusMessage": "string",
}
