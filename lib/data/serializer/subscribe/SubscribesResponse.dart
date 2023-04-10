// To parse this JSON data, do
//
//     final subscribesItem = subscribesItemFromJson(jsonString);

import 'dart:convert';

List<SubscribeItem> subscribesResponseFromJson(String str) => List<SubscribeItem>.from(json.decode(str).map((x) => SubscribeItem.fromJson(x)));

String subscribesItemToJson(List<SubscribeItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubscribeItem {
  SubscribeItem({
    this.id,
    this.title,
    this.description,
    this.discountPrice,
    this.price,
    this.durationDay,
    this.isActive,
    this.adminId,
    this.iconUrl,
    this.file,
  });

  int? id;
  String? title;
  String? description;
  int? discountPrice;
  int? price;
  int? durationDay;
  bool? isActive;
  int? adminId;
  String? iconUrl;
  String? file;

  factory SubscribeItem.fromJson(Map<String, dynamic> json) => SubscribeItem(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    discountPrice: json["discountPrice"],
    price: json["price"],
    durationDay: json["durationDay"],
    isActive: json["isActive"],
    adminId: json["adminId"],
    iconUrl: json["iconUrl"],
    file: json["file"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "discountPrice": discountPrice,
    "price": price,
    "durationDay": durationDay,
    "isActive": isActive,
    "adminId": adminId,
    "iconUrl": iconUrl,
    "file": file,
  };
}
