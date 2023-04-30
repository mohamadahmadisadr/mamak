import 'dart:convert';

import 'package:mamak/presentation/uiModel/workBook/WorkBookDetailUiModel.dart';

WorkBookDetailResponse workBookDetailResponseFromJson(String str) =>
    WorkBookDetailResponse.fromJson(json.decode(str));

String workBookDetailResponseToJson(WorkBookDetailResponse data) =>
    json.encode(data.toJson());

class WorkBookDetailResponse {
  WorkBookDetailResponse({
    this.reportCardHeader,
    this.workShopReportCard,
    this.workShopReportCardDetails,
    this.generalReportCards,
    this.generalReportCardDetails,
  });

  WorkBookDetailResponse.fromJson(dynamic json) {
    reportCardHeader = json['reportCardHeader'] != null
        ? ReportCardHeader.fromJson(json['reportCardHeader'])
        : null;
    workShopReportCard = json['workShopReportCard'] != null
        ? WorkShopReportCard.fromJson(json['workShopReportCard'])
        : null;
    if (json['workShopReportCardDetails'] != null) {
      workShopReportCardDetails = [];
      json['workShopReportCardDetails'].forEach((v) {
        workShopReportCardDetails?.add(WorkShopReportCardDetails.fromJson(v));
      });
    }
    if (json['generalReportCards'] != null) {
      generalReportCards = [];
      json['generalReportCards'].forEach((v) {
        generalReportCards?.add(GeneralReportCards.fromJson(v));
      });
    }
    generalReportCardDetails = json['generalReportCardDetails'] != null
        ? GeneralReportCardDetails.fromJson(json['generalReportCardDetails'])
        : null;
  }

  ReportCardHeader? reportCardHeader;
  WorkShopReportCard? workShopReportCard;
  List<WorkShopReportCardDetails>? workShopReportCardDetails;
  List<GeneralReportCards>? generalReportCards;
  GeneralReportCardDetails? generalReportCardDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (reportCardHeader != null) {
      map['reportCardHeader'] = reportCardHeader?.toJson();
    }
    if (workShopReportCard != null) {
      map['workShopReportCard'] = workShopReportCard?.toJson();
    }
    if (workShopReportCardDetails != null) {
      map['workShopReportCardDetails'] =
          workShopReportCardDetails?.map((v) => v.toJson()).toList();
    }
    if (generalReportCards != null) {
      map['generalReportCards'] =
          generalReportCards?.map((v) => v.toJson()).toList();
    }
    if (generalReportCardDetails != null) {
      map['generalReportCardDetails'] = generalReportCardDetails?.toJson();
    }
    return map;
  }
}

GeneralReportCardDetails generalReportCardDetailsFromJson(String str) =>
    GeneralReportCardDetails.fromJson(json.decode(str));

String generalReportCardDetailsToJson(GeneralReportCardDetails data) =>
    json.encode(data.toJson());

class GeneralReportCardDetails {
  GeneralReportCardDetails({
    this.allWorkShopTitles,
    this.participatedWorkShopTitles,
    this.allWorkShopsCount,
    this.participatedWorkShopsCount,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  GeneralReportCardDetails.fromJson(dynamic json) {
    allWorkShopTitles = json['allWorkShopTitles'] != null
        ? json['allWorkShopTitles'].cast<String>()
        : [];
    participatedWorkShopTitles = json['participatedWorkShopTitles'] != null
        ? json['participatedWorkShopTitles'].cast<String>()
        : [];
    allWorkShopsCount = json['allWorkShopsCount'];
    participatedWorkShopsCount = json['participatedWorkShopsCount'];
    id = json['id'];
  }

  List<String>? allWorkShopTitles;
  List<String>? participatedWorkShopTitles;
  num? allWorkShopsCount;
  num? participatedWorkShopsCount;
  num? id;
  List<dynamic>? errorMessages;
  num? statusCode;
  List<dynamic>? successfulMessages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['allWorkShopTitles'] = allWorkShopTitles;
    map['participatedWorkShopTitles'] = participatedWorkShopTitles;
    map['allWorkShopsCount'] = allWorkShopsCount;
    map['participatedWorkShopsCount'] = participatedWorkShopsCount;
    map['id'] = id;
    if (errorMessages != null) {
      map['errorMessages'] = errorMessages?.map((v) => v.toJson()).toList();
    }
    map['statusCode'] = statusCode;
    if (successfulMessages != null) {
      map['successfulMessages'] =
          successfulMessages?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

GeneralReportCards generalReportCardsFromJson(String str) =>
    GeneralReportCards.fromJson(json.decode(str));

String generalReportCardsToJson(GeneralReportCards data) =>
    json.encode(data.toJson());

class GeneralReportCards {
  GeneralReportCards({
    this.workShopReportCards,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  GeneralReportCards.fromJson(dynamic json) {
    if (json['workShopReportCards'] != null) {
      workShopReportCards = [];
      json['workShopReportCards'].forEach((v) {
        workShopReportCards?.add(WorkShopReportCards.fromJson(v));
      });
    }
    id = json['id'];
    statusCode = json['statusCode'];
  }

  List<WorkShopReportCards>? workShopReportCards;
  num? id;
  List<dynamic>? errorMessages;
  num? statusCode;
  List<dynamic>? successfulMessages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (workShopReportCards != null) {
      map['workShopReportCards'] =
          workShopReportCards?.map((v) => v.toJson()).toList();
    }
    map['id'] = id;
    if (errorMessages != null) {
      map['errorMessages'] = errorMessages?.map((v) => v.toJson()).toList();
    }
    map['statusCode'] = statusCode;
    if (successfulMessages != null) {
      map['successfulMessages'] =
          successfulMessages?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

WorkShopReportCards workShopReportCardsFromJson(String str) =>
    WorkShopReportCards.fromJson(json.decode(str));

String workShopReportCardsToJson(WorkShopReportCards data) =>
    json.encode(data.toJson());

class WorkShopReportCards {
  WorkShopReportCards({
    this.workShopCategoryTitle,
    this.allQuestionsCount,
    this.firstRateAnswersCount,
    this.secondRateAnswersCount,
    this.thirdRateAnswersCount,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  WorkShopReportCards.fromJson(dynamic json) {
    workShopCategoryTitle = json['workShopCategoryTitle'];
    allQuestionsCount = json['allQuestionsCount'];
    firstRateAnswersCount = json['firstRateAnswersCount'];
    secondRateAnswersCount = json['secondRateAnswersCount'];
    thirdRateAnswersCount = json['thirdRateAnswersCount'];
    id = json['id'];

    statusCode = json['statusCode'];
  }

  String? workShopCategoryTitle;
  num? allQuestionsCount;
  num? firstRateAnswersCount;
  num? secondRateAnswersCount;
  num? thirdRateAnswersCount;
  num? id;
  List<dynamic>? errorMessages;
  num? statusCode;
  List<dynamic>? successfulMessages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['workShopCategoryTitle'] = workShopCategoryTitle;
    map['allQuestionsCount'] = allQuestionsCount;
    map['firstRateAnswersCount'] = firstRateAnswersCount;
    map['secondRateAnswersCount'] = secondRateAnswersCount;
    map['thirdRateAnswersCount'] = thirdRateAnswersCount;
    map['id'] = id;
    if (errorMessages != null) {
      map['errorMessages'] = errorMessages?.map((v) => v.toJson()).toList();
    }
    map['statusCode'] = statusCode;
    if (successfulMessages != null) {
      map['successfulMessages'] =
          successfulMessages?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

WorkShopReportCardDetails workShopReportCardDetailsFromJson(String str) =>
    WorkShopReportCardDetails.fromJson(json.decode(str));

String workShopReportCardDetailsToJson(WorkShopReportCardDetails data) =>
    json.encode(data.toJson());

class WorkShopReportCardDetails {
  WorkShopReportCardDetails({
    this.question,
    this.answer,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  WorkShopReportCardDetails.fromJson(dynamic json) {
    question = json['question'];
    answer = json['answer'];
    id = json['id'];
    statusCode = json['statusCode'];
  }

  String? question;
  String? answer;
  num? id;
  List<dynamic>? errorMessages;
  num? statusCode;
  List<dynamic>? successfulMessages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['question'] = question;
    map['answer'] = answer;
    map['id'] = id;
    if (errorMessages != null) {
      map['errorMessages'] = errorMessages?.map((v) => v.toJson()).toList();
    }
    map['statusCode'] = statusCode;
    if (successfulMessages != null) {
      map['successfulMessages'] =
          successfulMessages?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

WorkShopReportCard workShopReportCardFromJson(String str) =>
    WorkShopReportCard.fromJson(json.decode(str));

String workShopReportCardToJson(WorkShopReportCard data) =>
    json.encode(data.toJson());

class WorkShopReportCard {
  WorkShopReportCard({
    this.workShopCategoryTitle,
    this.allQuestionsCount,
    this.firstRateAnswersCount,
    this.secondRateAnswersCount,
    this.thirdRateAnswersCount,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  WorkShopReportCard.fromJson(dynamic json) {
    workShopCategoryTitle = json['workShopCategoryTitle'];
    allQuestionsCount = json['allQuestionsCount'];
    firstRateAnswersCount = json['firstRateAnswersCount'];
    secondRateAnswersCount = json['secondRateAnswersCount'];
    thirdRateAnswersCount = json['thirdRateAnswersCount'];
    id = json['id'];
    statusCode = json['statusCode'];
  }

  String? workShopCategoryTitle;
  num? allQuestionsCount;
  num? firstRateAnswersCount;
  num? secondRateAnswersCount;
  num? thirdRateAnswersCount;
  num? id;
  List<dynamic>? errorMessages;
  num? statusCode;
  List<dynamic>? successfulMessages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['workShopCategoryTitle'] = workShopCategoryTitle;
    map['allQuestionsCount'] = allQuestionsCount;
    map['firstRateAnswersCount'] = firstRateAnswersCount;
    map['secondRateAnswersCount'] = secondRateAnswersCount;
    map['thirdRateAnswersCount'] = thirdRateAnswersCount;
    map['id'] = id;
    if (errorMessages != null) {
      map['errorMessages'] = errorMessages?.map((v) => v.toJson()).toList();
    }
    map['statusCode'] = statusCode;
    if (successfulMessages != null) {
      map['successfulMessages'] =
          successfulMessages?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

ReportCardHeader reportCardHeaderFromJson(String str) =>
    ReportCardHeader.fromJson(json.decode(str));

String reportCardHeaderToJson(ReportCardHeader data) =>
    json.encode(data.toJson());

class ReportCardHeader {
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

  ReportCardHeader.fromJson(dynamic json) {
    parentUserFullName = json['parentUserFullName'];
    childUserFullName = json['childUserFullName'];
    childAge = json['childAge'];
    workShopCategoryTitle = json['workShopCategoryTitle'];
    id = json['id'];

    statusCode = json['statusCode'];
  }

  String? parentUserFullName;
  String? childUserFullName;
  num? childAge;
  String? workShopCategoryTitle;
  num? id;
  List<dynamic>? errorMessages;
  num? statusCode;
  List<dynamic>? successfulMessages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['parentUserFullName'] = parentUserFullName;
    map['childUserFullName'] = childUserFullName;
    map['childAge'] = childAge;
    map['workShopCategoryTitle'] = workShopCategoryTitle;
    map['id'] = id;
    if (errorMessages != null) {
      map['errorMessages'] = errorMessages?.map((v) => v.toJson()).toList();
    }
    map['statusCode'] = statusCode;
    if (successfulMessages != null) {
      map['successfulMessages'] =
          successfulMessages?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

extension WorkBookDetailExtension on WorkBookDetailResponse {
  WorkBookDetailUiModel createUiModel() {
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
    return WorkBookDetailUiModel(header: header, reviews: reviews);
  }
}
