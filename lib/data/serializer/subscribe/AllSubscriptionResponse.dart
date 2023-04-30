// To parse this JSON data, do
//
//     final allSubscriptionItem = allSubscriptionItemFromJson(jsonString);

import 'dart:convert';

List<AllSubscriptionItem> allSubscriptionItemFromJson(String str) => List<AllSubscriptionItem>.from(json.decode(str).map((x) => AllSubscriptionItem.fromJson(x)));

String allSubscriptionItemToJson(List<AllSubscriptionItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllSubscriptionItem {
  int? id;
  String? title;
  int? price;
  int? durationDay;
  List<dynamic>? errorMessages;
  int? statusCode;
  List<dynamic>? successfulMessages;

  AllSubscriptionItem({
    this.id,
    this.title,
    this.price,
    this.durationDay,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  factory AllSubscriptionItem.fromJson(Map<String, dynamic> json) => AllSubscriptionItem(
    id: json["id"],
    title: json["title"],
    price: json["price"],
    durationDay: json["durationDay"],
    errorMessages: json["errorMessages"] == null ? [] : List<dynamic>.from(json["errorMessages"]!.map((x) => x)),
    statusCode: json["statusCode"],
    successfulMessages: json["successfulMessages"] == null ? [] : List<dynamic>.from(json["successfulMessages"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "durationDay": durationDay,
    "errorMessages": errorMessages == null ? [] : List<dynamic>.from(errorMessages!.map((x) => x)),
    "statusCode": statusCode,
    "successfulMessages": successfulMessages == null ? [] : List<dynamic>.from(successfulMessages!.map((x) => x)),
  };
}
