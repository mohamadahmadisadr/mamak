// To parse this JSON data, do
//
//     final workBook = workBookFromJson(jsonString);

import 'dart:convert';

List<WorkBook> workBooksFromJson(String str) => List<WorkBook>.from(json.decode(str).map((x) => WorkBook.fromJson(x)));

String workBooksToJson(List<WorkBook> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WorkBook {
  String? workShopTitle;
  String? packageAgeDomain;
  int? workShopId;

  WorkBook({
    this.workShopTitle,
    this.packageAgeDomain,
    this.workShopId,
  });

  factory WorkBook.fromJson(Map<String, dynamic> json) => WorkBook(
    workShopTitle: json["workShopTitle"],
    packageAgeDomain: json["packageAgeDomain"],
    workShopId: json["workShopId"],
  );

  Map<String, dynamic> toJson() => {
    "workShopTitle": workShopTitle,
    "packageAgeDomain": packageAgeDomain,
    "workShopId": workShopId,
  };
}
