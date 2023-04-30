// To parse this JSON data, do
//
//     final subscribeItem = subscribeItemFromJson(jsonString);

import 'dart:convert';

List<SubscribeItem> subscribesResponseFromJson(String str) =>
    List<SubscribeItem>.from(
        json.decode(str).map((x) => SubscribeItem.fromJson(x)));

String subscribeItemToJson(List<SubscribeItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubscribeItem {
  dynamic ageDomain;
  String? title;
  String? description;
  bool? isActive;
  int? ageDomainId;
  int? id;
  List<dynamic>? errorMessages;
  int? statusCode;
  List<dynamic>? successfulMessages;

  SubscribeItem({
    this.ageDomain,
    this.title,
    this.description,
    this.isActive,
    this.ageDomainId,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  factory SubscribeItem.fromJson(Map<String, dynamic> json) => SubscribeItem(
        ageDomain: json["ageDomain"],
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
        "ageDomain": ageDomain,
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

extension SubscribeItemExtension on SubscribeItem {
  bool isValidForChild(String? childPackageId) =>
      id?.toString() == childPackageId;
}
