class WorkBookParamsModel {
  String userChildId, workShopId;

  WorkBookParamsModel({this.userChildId = '', this.workShopId = ''});

  Map<String, String> toJson() =>
      {'userChildId': userChildId, 'workShopId': workShopId};
}
