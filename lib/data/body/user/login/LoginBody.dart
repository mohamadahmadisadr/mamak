import 'package:json_annotation/json_annotation.dart';

part 'LoginBody.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginBody {
  LoginBody({
    required this.mobile,
    required this.password,
  });

  final String mobile, password;
}
