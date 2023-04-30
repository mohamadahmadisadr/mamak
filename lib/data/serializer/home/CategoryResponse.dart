// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

List<Category> categoryFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  dynamic files;
  dynamic subCategories;
  dynamic workShops;
  String? title;
  String? description;
  int? id;
  List<dynamic>? errorMessages;
  int? statusCode;
  List<dynamic>? successfulMessages;

  Category({
    this.files,
    this.subCategories,
    this.workShops,
    this.title,
    this.description,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    files: json["files"],
    subCategories: json["subCategories"],
    workShops: json["workShops"],
    title: json["title"],
    description: json["description"],
    id: json["id"],
    errorMessages: json["errorMessages"] == null ? [] : List<dynamic>.from(json["errorMessages"]!.map((x) => x)),
    statusCode: json["statusCode"],
    successfulMessages: json["successfulMessages"] == null ? [] : List<dynamic>.from(json["successfulMessages"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "files": files,
    "subCategories": subCategories,
    "workShops": workShops,
    "title": title,
    "description": description,
    "id": id,
    "errorMessages": errorMessages == null ? [] : List<dynamic>.from(errorMessages!.map((x) => x)),
    "statusCode": statusCode,
    "successfulMessages": successfulMessages == null ? [] : List<dynamic>.from(successfulMessages!.map((x) => x)),
  };
}
