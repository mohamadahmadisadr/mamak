import 'dart:convert';
SignInResponse signInResponseFromJson(String str) => SignInResponse.fromJson(json.decode(str));
String signInResponseToJson(SignInResponse data) => json.encode(data.toJson());
class SignInResponse {
  SignInResponse({
      this.isSuccess, 
      this.message, 
      this.data,});

  SignInResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? User.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  User? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isSuccess'] = isSuccess;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

User dataFromJson(String str) => User.fromJson(json.decode(str));
String dataToJson(User data) => json.encode(data.toJson());
class User {
  User({
      this.userId, 
      this.roles, 
      this.fullName, 
      this.isActive, 
      this.mobile, 
      this.expireDate, 
      this.isAuthorized,});

  User.fromJson(dynamic json) {
    userId = json['userId'];
    roles = json['roles'] != null ? json['roles'].cast<String>() : [];
    fullName = json['fullName'];
    isActive = json['isActive'];
    mobile = json['mobile'];
    expireDate = json['expireDate'];
    isAuthorized = json['isAuthorized'];
  }
  num? userId;
  List<String>? roles;
  String? fullName;
  bool? isActive;
  String? mobile;
  String? expireDate;
  bool? isAuthorized;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['roles'] = roles;
    map['fullName'] = fullName;
    map['isActive'] = isActive;
    map['mobile'] = mobile;
    map['expireDate'] = expireDate;
    map['isAuthorized'] = isAuthorized;
    return map;
  }

}