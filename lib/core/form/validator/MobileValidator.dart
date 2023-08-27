import 'package:get/get.dart';
import 'package:mamak/core/locale/locale_extension.dart';

import 'ValidationState.dart';
import 'Validator.dart';

import 'package:flutter/widgets.dart';


class MobileValidator extends Validator {
  @override
  ValidationState validate(String data) {
    if (data.isEmpty) {
      return ValidationState(
          state: false, msg: 'enter_mobile'.tr);
    }
    if(!Get.locale.isPersian){
      return const ValidationState(state: true);
    }
    if (data.length < 11) {
      return const ValidationState(
          state: false, msg: 'شماره موبایل وارد شده کمتر از ۱۱ رقم است');
    }
    if (!data.startsWith('09')) {
      return const ValidationState(
          state: false, msg: 'شماره موبایل وارد شده صحیح نیست.');
    }
    return const ValidationState(state: true);
  }

  static TextInputType mobileInputType = TextInputType.phone;
}
