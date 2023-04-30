import 'package:json_annotation/json_annotation.dart';
import 'package:mamak/data/body/user/profile/FileDataBody.dart';

part 'AddChildBody.g.dart';

@JsonSerializable(explicitToJson: true)
class AddChildBody {
  AddChildBody({
    required this.childFirstName,
    required this.childLastName,
    required this.birtDate,
    required this.mobileNumber,
    this.childPicture
  });

  String childFirstName, childLastName, birtDate, mobileNumber;
  final FileDataBody? childPicture;

  AddChildBody fromJson(Map<String, dynamic> json) =>
      _$AddChildBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddChildBodyToJson(this);
}
