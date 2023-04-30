import 'dart:convert';

import 'package:get/get.dart';

import 'ImageResponse.dart';

List<ChildPackage> childPackageFromJson(String str) => List<ChildPackage>.from(
    json.decode(str).map((x) => ChildPackage.fromJson(x)));

String childPackageToJson(List<ChildPackage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChildPackage {
  String? childName;
  ImageResponse? childPicture;
  List<Package>? packages;
  int? id;
  List<dynamic>? errorMessages;
  int? statusCode;
  List<dynamic>? successfulMessages;

  ChildPackage({
    this.childName,
    this.childPicture,
    this.packages,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  factory ChildPackage.fromJson(Map<String, dynamic> json) => ChildPackage(
        childName: json["childName"],
        childPicture: json["childPicture"] != null
            ? imageResponseFromJson(jsonEncode(json["childPicture"]))
            : null,
        packages: json["packages"] == null
            ? []
            : List<Package>.from(
                json["packages"]!.map((x) => Package.fromJson(x))),
        id: json["id"],
        errorMessages: json["errorMessages"] == null
            ? []
            : List<dynamic>.from(json["errorMessages"]!.map((x) => x)),
        statusCode: json["statusCode"],
        successfulMessages: json["successfulMessages"] == null
            ? []
            : List<dynamic>.from(json["successfulMessages"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "childName": childName,
        "childPicture": childPicture,
        "packages": packages == null
            ? []
            : List<dynamic>.from(packages!.map((x) => x.toJson())),
        "id": id,
        "errorMessages": errorMessages == null
            ? []
            : List<dynamic>.from(errorMessages!.map((x) => x)),
        "statusCode": statusCode,
        "successfulMessages": successfulMessages == null
            ? []
            : List<dynamic>.from(successfulMessages!.map((x) => x)),
      };
}

class Package {
  String? title;
  String? description;
  bool? isActive;
  int? ageDomainId;
  int? id;
  List<dynamic>? errorMessages;
  int? statusCode;
  List<dynamic>? successfulMessages;

  Package({
    this.title,
    this.description,
    this.isActive,
    this.ageDomainId,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        title: json["title"],
        description: json["description"],
        isActive: json["isActive"],
        ageDomainId: json["ageDomainId"],
        id: json["id"],
        errorMessages: json["errorMessages"] == null
            ? []
            : List<dynamic>.from(json["errorMessages"]!.map((x) => x)),
        statusCode: json["statusCode"],
        successfulMessages: json["successfulMessages"] == null
            ? []
            : List<dynamic>.from(json["successfulMessages"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "isActive": isActive,
        "ageDomainId": ageDomainId,
        "id": id,
        "errorMessages": errorMessages == null
            ? []
            : List<dynamic>.from(errorMessages!.map((x) => x)),
        "statusCode": statusCode,
        "successfulMessages": successfulMessages == null
            ? []
            : List<dynamic>.from(successfulMessages!.map((x) => x)),
      };
}

extension ChildListPackageExtension on List<ChildPackage> {
  ChildPackage? getChildPackage(String? subscribeId) {
    return firstWhereOrNull((element) => element.id?.toString() == subscribeId);
  }
}
