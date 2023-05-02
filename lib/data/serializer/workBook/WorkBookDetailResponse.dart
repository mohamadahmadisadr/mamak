// To parse this JSON data, do
//

// To parse this JSON data, do
//
//     final workBookDetailResponse = workBookDetailResponseFromJson(jsonString);

// To parse this JSON data, do
//
//     final workBookDetailResponse = workBookDetailResponseFromJson(jsonString);

// To parse this JSON data, do
//
//     final workBookDetailResponse = workBookDetailResponseFromJson(jsonString);

import 'dart:convert';

import 'package:mamak/presentation/uiModel/workBook/ChartDataModel.dart';
import 'package:mamak/presentation/uiModel/workBook/WorkBookDetailUiModel.dart';
import 'package:mamak/presentation/uiModel/workBook/WorkBookParamsModel.dart';
import 'package:mamak/presentation/uiModel/workBook/WorkBookTableModel.dart';

WorkBookDetailResponse workBookDetailResponseFromJson(String str) =>
    WorkBookDetailResponse.fromJson(json.decode(str));

String workBookDetailResponseToJson(WorkBookDetailResponse data) =>
    json.encode(data.toJson());

class WorkBookDetailResponse {
  ReportCardHeader? reportCardHeader;
  WorkShopReportCard? workShopReportCard;
  List<WorkShopReportCardDetail>? workShopReportCardDetails;
  List<GeneralReportCard>? generalReportCards;
  GeneralReportCardDetails? generalReportCardDetails;
  List<WorkShopReportCard>? workShopSubCategoryReportCards;
  int? id;
  List<dynamic>? errorMessages;
  int? statusCode;
  List<dynamic>? successfulMessages;

  WorkBookDetailResponse({
    this.reportCardHeader,
    this.workShopReportCard,
    this.workShopReportCardDetails,
    this.generalReportCards,
    this.generalReportCardDetails,
    this.workShopSubCategoryReportCards,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  factory WorkBookDetailResponse.fromJson(Map<String, dynamic> json) =>
      WorkBookDetailResponse(
        reportCardHeader: json["reportCardHeader"] == null
            ? null
            : ReportCardHeader.fromJson(json["reportCardHeader"]),
        workShopReportCard: json["workShopReportCard"] == null
            ? null
            : WorkShopReportCard.fromJson(json["workShopReportCard"]),
        workShopReportCardDetails: json["workShopReportCardDetails"] == null
            ? []
            : List<WorkShopReportCardDetail>.from(
                json["workShopReportCardDetails"]!
                    .map((x) => WorkShopReportCardDetail.fromJson(x))),
        generalReportCards: json["generalReportCards"] == null
            ? []
            : List<GeneralReportCard>.from(json["generalReportCards"]!
                .map((x) => GeneralReportCard.fromJson(x))),
        generalReportCardDetails: json["generalReportCardDetails"] == null
            ? null
            : GeneralReportCardDetails.fromJson(
                json["generalReportCardDetails"]),
        workShopSubCategoryReportCards:
            json["workShopSubCategoryReportCards"] == null
                ? []
                : List<WorkShopReportCard>.from(
                    json["workShopSubCategoryReportCards"]!
                        .map((x) => WorkShopReportCard.fromJson(x))),
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
        "reportCardHeader": reportCardHeader?.toJson(),
        "workShopReportCard": workShopReportCard?.toJson(),
        "workShopReportCardDetails": workShopReportCardDetails == null
            ? []
            : List<dynamic>.from(
                workShopReportCardDetails!.map((x) => x.toJson())),
        "generalReportCards": generalReportCards == null
            ? []
            : List<dynamic>.from(generalReportCards!.map((x) => x.toJson())),
        "generalReportCardDetails": generalReportCardDetails?.toJson(),
        "workShopSubCategoryReportCards": workShopSubCategoryReportCards == null
            ? []
            : List<dynamic>.from(
                workShopSubCategoryReportCards!.map((x) => x.toJson())),
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

class GeneralReportCardDetails {
  Dictionary? allWorkShopsDictionary;
  int? allWorkShopsCount;
  int? participatedWorkShopsCount;
  int? id;
  List<dynamic>? errorMessages;
  int? statusCode;
  List<dynamic>? successfulMessages;

  GeneralReportCardDetails({
    this.allWorkShopsDictionary,
    this.allWorkShopsCount,
    this.participatedWorkShopsCount,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  factory GeneralReportCardDetails.fromJson(Map<String, dynamic> json) =>
      GeneralReportCardDetails(
        allWorkShopsDictionary: json["allWorkShopsDictionary"] == null
            ? null
            : Dictionary.fromJson(json["allWorkShopsDictionary"]),
        allWorkShopsCount: json["allWorkShopsCount"],
        participatedWorkShopsCount: json["participatedWorkShopsCount"],
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
        "allWorkShopsDictionary": allWorkShopsDictionary?.toJson(),
        "allWorkShopsCount": allWorkShopsCount,
        "participatedWorkShopsCount": participatedWorkShopsCount,
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

class Dictionary {
  String? the1;

  Dictionary({
    this.the1,
  });

  factory Dictionary.fromJson(Map<String, dynamic> json) => Dictionary(
        the1: json["1"],
      );

  Map<String, dynamic> toJson() => {
        "1": the1,
      };
}

class GeneralReportCard {
  List<WorkShopReportCard>? workShopReportCards;
  int? id;
  List<dynamic>? errorMessages;
  int? statusCode;
  List<dynamic>? successfulMessages;

  GeneralReportCard({
    this.workShopReportCards,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  factory GeneralReportCard.fromJson(Map<String, dynamic> json) =>
      GeneralReportCard(
        workShopReportCards: json["workShopReportCards"] == null
            ? []
            : List<WorkShopReportCard>.from(json["workShopReportCards"]!
                .map((x) => WorkShopReportCard.fromJson(x))),
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
        "workShopReportCards": workShopReportCards == null
            ? []
            : List<dynamic>.from(workShopReportCards!.map((x) => x.toJson())),
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

class WorkShopReportCard {
  Map<dynamic, dynamic>? workShopDictionary;
  int? allQuestionsCount;
  int? firstRateAnswersCount;
  int? secondRateAnswersCount;
  int? thirdRateAnswersCount;
  int? id;
  List<dynamic>? errorMessages;
  int? statusCode;
  List<dynamic>? successfulMessages;
  Map<String, String>? categoryDictionary;

  WorkShopReportCard({
    this.workShopDictionary,
    this.allQuestionsCount,
    this.firstRateAnswersCount,
    this.secondRateAnswersCount,
    this.thirdRateAnswersCount,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
    this.categoryDictionary,
  });

  factory WorkShopReportCard.fromJson(Map<String, dynamic> json) =>
      WorkShopReportCard(
        workShopDictionary: json["workShopDictionary"] == null
            ? null
            : Map.from(json["workShopDictionary"])
                .map((k, v) => MapEntry<dynamic, dynamic>(k, v)),
        allQuestionsCount: json["allQuestionsCount"],
        firstRateAnswersCount: json["firstRateAnswersCount"],
        secondRateAnswersCount: json["secondRateAnswersCount"],
        thirdRateAnswersCount: json["thirdRateAnswersCount"],
        id: json["id"],
        errorMessages: json["errorMessages"] == null
            ? []
            : List<dynamic>.from(json["errorMessages"]!.map((x) => x)),
        statusCode: json["statusCode"],
        successfulMessages: json["successfulMessages"] == null
            ? []
            : List<dynamic>.from(json["successfulMessages"]!.map((x) => x)),
        categoryDictionary: json["categoryDictionary"] == null
            ? null
            : Map.from(json["categoryDictionary"]!)
                .map((k, v) => MapEntry<String, String>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "workShopDictionary": workShopDictionary?.toString(),
        "allQuestionsCount": allQuestionsCount,
        "firstRateAnswersCount": firstRateAnswersCount,
        "secondRateAnswersCount": secondRateAnswersCount,
        "thirdRateAnswersCount": thirdRateAnswersCount,
        "id": id,
        "errorMessages": errorMessages == null
            ? []
            : List<dynamic>.from(errorMessages!.map((x) => x)),
        "statusCode": statusCode,
        "successfulMessages": successfulMessages == null
            ? []
            : List<dynamic>.from(successfulMessages!.map((x) => x)),
        "categoryDictionary": Map.from(categoryDictionary!)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

class ReportCardHeader {
  String? parentUserFullName;
  String? childUserFullName;
  int? childAge;
  String? workShopCategoryTitle;
  int? id;
  List<dynamic>? errorMessages;
  int? statusCode;
  List<dynamic>? successfulMessages;

  ReportCardHeader({
    this.parentUserFullName,
    this.childUserFullName,
    this.childAge,
    this.workShopCategoryTitle,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  factory ReportCardHeader.fromJson(Map<String, dynamic> json) =>
      ReportCardHeader(
        parentUserFullName: json["parentUserFullName"],
        childUserFullName: json["childUserFullName"],
        childAge: json["childAge"],
        workShopCategoryTitle: json["workShopCategoryTitle"],
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
        "parentUserFullName": parentUserFullName,
        "childUserFullName": childUserFullName,
        "childAge": childAge,
        "workShopCategoryTitle": workShopCategoryTitle,
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

class WorkShopReportCardDetail {
  String? question;
  String? answer;
  int? id;
  List<dynamic>? errorMessages;
  int? statusCode;
  List<dynamic>? successfulMessages;

  WorkShopReportCardDetail({
    this.question,
    this.answer,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  factory WorkShopReportCardDetail.fromJson(Map<String, dynamic> json) =>
      WorkShopReportCardDetail(
        question: json["question"],
        answer: json["answer"],
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
        "question": question,
        "answer": answer,
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

extension WorkBookDetailExtension on WorkBookDetailResponse {
  WorkBookDetailUiModel createUiModel(WorkBookParamsModel model) {
    List<String> headerTitle = [
      'نام مادر',
      'نام کودک',
      'سن کودک',
      'کارگاه ارزیابی',
    ];
    List<String> header = [
      reportCardHeader?.parentUserFullName ?? '',
      reportCardHeader?.childUserFullName ?? '',
      '${reportCardHeader?.childAge?.toString() ?? ' '} سال',
      reportCardHeader?.workShopCategoryTitle ?? '',
    ];
    List<WorkBookDetailReviews> reviews = workShopReportCardDetails
            ?.map((e) => WorkBookDetailReviews(
                question: e.question ?? '', comment: e.answer ?? ''))
            .toList() ??
        [];
    print(model.workShopId);

    var workShopName =
        '${workShopReportCard?.workShopDictionary?[model.workShopId]}';
    var one = workShopReportCard?.firstRateAnswersCount?.toString() ?? '';
    var two = workShopReportCard?.secondRateAnswersCount?.toString() ?? '';
    var three = workShopReportCard?.thirdRateAnswersCount?.toString() ?? '';
    var allQCount = workShopReportCard?.allQuestionsCount?.toString() ?? '';
    var workShopWorkBookTitle =
        'مهارت کودک در $workShopName : $three از $allQCount';

    var workShopDescription =
        'طبق ارزیابی شما, از بین $allQCount توانمندی $workShopName کودک شما بر $three توانمندی مسلط است, $two توانمندی را تا حدودی و $one توانمدی را هنوز شروع نکرده است.';

    int maxValue = workShopSubCategoryReportCards?.fold(
            0,
            (previousValue, element) =>
                (previousValue ?? 0) + (element.allQuestionsCount ?? 0)) ??
        0;
    List<String> names = workShopSubCategoryReportCards
            ?.map((e) => e.categoryDictionary?.values.first.toString() ?? '')
            .toList() ??
        [];
    List<String> lableData = [];
    List<double> values = workShopSubCategoryReportCards?.map((e) {
          int all = e.allQuestionsCount ?? 0;
          int correct = e.thirdRateAnswersCount ?? 0;
          lableData.add('$correct از $all');
          return (maxValue * correct) / all;
        }).toList() ??
        [];

    var cards = generalReportCards ?? [];
    var totalWorkBookTitle = 'همه جانبگی ارزیابی: %s حوزه از %s حوزه';
    print('maxValue : $maxValue');
    print(names);
    print(values);
    List<List<WorkBookTableModel>> tableData = [];
    var prev = 0;
    generalReportCards?.forEach((e) {
      List<WorkBookTableModel> worksShops = [];
      e.workShopReportCards?.forEach((element) {
        worksShops.add(
          WorkBookTableModel(
            id: element.workShopDictionary?.keys.first ?? '0',
            previousThree: prev,
            three: element.thirdRateAnswersCount ?? 0,
            count: element.allQuestionsCount?.toString() ?? '',
          ),
        );
        prev = element.thirdRateAnswersCount ?? 0;
      });
      tableData.add(worksShops);
    });

    ChartDataModel workShopChartData =
        ChartDataModel(maxValue: maxValue, name: names, values: values,lableData: lableData);
    var counter = 'ارزیابی ۱';
    return WorkBookDetailUiModel(
      headerTitle: headerTitle,
      header: header,
      reviews: reviews,
      workShop: workShopName,
      workShopWorkBookTitle: workShopWorkBookTitle,
      workShopWorkBookDescription: workShopDescription,
      counter: counter,
      workShpChartModel: workShopChartData,
      cards: cards,
      totalWorkBookTitle: totalWorkBookTitle,
      tableData: tableData,
    );
  }
}

extension WorkShopReportExtension on List<WorkShopReportCard>? {
  int get getMaxValue =>
      this?.fold(
          0,
          (previousValue, element) =>
              (previousValue ?? 0) > (element.allQuestionsCount ?? 0)
                  ? previousValue
                  : (element.allQuestionsCount ?? 0)) ??
      0;
}
