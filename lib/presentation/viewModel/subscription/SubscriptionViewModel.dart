import 'package:core/Notification/MyNotification.dart';
import 'package:core/network/errorHandler/ErrorModel.dart';
import 'package:core/network/errorHandler/common/ErrorMessages.dart';
import 'package:core/utils/logger/Logger.dart';
import 'package:feature/jwt/jwt_generator.dart';
import 'package:feature/poolakey/inapp_purchase_info.dart';
import 'package:feature/poolakey/poolakey_helper.dart';
import 'package:flutter/material.dart';
import 'package:mamak/data/body/subscribe/AddSubscribeBody.dart';
import 'package:mamak/data/body/subscribe/DiscountCodeBody.dart';
import 'package:mamak/data/serializer/subscribe/AllSubscriptionResponse.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/HomeNavigationModel.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/payment/PayOrderUseCase.dart';
import 'package:mamak/useCase/payment/payOrderResultByCafeBazaarUseCase.dart';
import 'package:mamak/useCase/subscribe/AddSubscribeUseCase.dart';
import 'package:mamak/useCase/subscribe/CurrentPackageUseCase.dart';
import 'package:mamak/useCase/subscribe/DiscountCodeUseCase.dart';
import 'package:mamak/useCase/subscribe/GetAllSubscriptionsUseCase.dart';
import 'package:mamak/useCase/subscribe/GetRemainingDayUseCase.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

class SubscriptionViewModel extends BaseViewModel with WidgetsBindingObserver {
  AppState uiState = AppState.idle;
  AppState adSubscribeState = AppState.idle;
  AppState discountCodeState = AppState.idle;
  AppState mySubscriptionState = AppState.idle;
  AllSubscriptionItem? selectedItem;
  String? dynamicPriceToken;
  final bool cafeBazaar = true;

  final TextEditingController codeController = TextEditingController();

  final MyNotification _notification = GetIt.I.get();
  final PoolakeyHelper _poolakeyHelper = GetIt.I.get();

  SubscriptionViewModel(super.initialState) {
    WidgetsBinding.instance.addObserver(this);

    getCurrentSubscription();
    getSubscriptions();
  }

  void getSubscriptions() {
    GetAllSubscriptionsUseCase().invoke(MyFlow(flow: (appState) {
      // if (appState.isSuccess) {
      //   if (appState.getData is List<AllSubscriptionItem>) {
      //     List<AllSubscriptionItem> child = appState.getData;
      //     if (child.isNotEmpty) {
      //       selectedItem = child.first;
      //     }
      //   }
      // }
      uiState = appState;
      refresh();
    }));
  }

  onChangeSelectedItem(AllSubscriptionItem? newSelected) {
    if (newSelected != null) {
      selectedItem = newSelected;
      dynamicPriceToken = null;
      refresh();
    }
  }

  void getCurrentSubscription() {
    CurrentPackageUseCase().invoke(MyFlow(flow: (appState) {
      // if(appState.isFailed){
      //   if (selectedItem == null) {
      //     getSubscriptions();
      //   }
      // }
      mySubscriptionState = appState;
      refresh();
    }));
  }

  void checkDiscountCode() {
    if (selectedItem != null && codeController.text.isNotEmpty) {
      DiscountCodeBody body = DiscountCodeBody(
          amount: selectedItem?.price?.toString() ?? '',
          code: codeController.text);

      DiscountCodeUseCase().invoke(MyFlow(flow: (appState) async {
        if (appState.isSuccess) {
          selectedItem?.discount = int.tryParse(appState.getData) ?? 0;
          dynamicPriceToken = await JwtGenerator().generateToken(
              pId: selectedItem?.cafeBazaarIdentity ?? '',
              price: selectedItem?.discount ?? 0);
        }
        if (appState.isFailed) {
          dynamicPriceToken = null;
          messageService.showSnackBar(appState.getErrorModel?.message ?? '');
        }
        discountCodeState = appState;
        refresh();
      }), data: body);
    }
  }

  void getRemainingDay() {
    GetRemainingDayUseCase().invoke(MyFlow(flow: (appState) {
      if (appState.isSuccess) {
        String count = appState.getData.toString();
        GetIt.I.get<MyNotification>().publish('MainViewModel', count);
      }
    }));
  }

  onChangeCode(String newCode) => codeController.text = newCode;

  void submitCode() {
    if (selectedItem == null) {
      messageService.showSnackBar('اشتراک مورد نظر را انتخاب کنید');
      return;
    }

    if (codeController.text.isEmpty || codeController.text.length < 4) {
      messageService.showSnackBar('کد تخفیف را وارد کنید');
      return;
    }

    checkDiscountCode();
  }

  void submitSubscribe() async {
    if (selectedItem == null) {
      messageService.showSnackBar('اشتراک موردنظر را انتخاب کنید');
      return;
    }

    AddSubscribeBody body = AddSubscribeBody(
      subscriptionId: selectedItem?.id?.toString() ?? '',
      discountCode: codeController.text,
    );
    AddSubscribeUseCase().invoke(
      MyFlow(flow: (appState) async {
        if (appState.isFailed) {
          messageService.showSnackBar(appState.getErrorModel?.message ?? '');
        }
        if (appState.isSuccess) {
          if (cafeBazaar) {
            try {
              var res = await _poolakeyHelper.purchase(
                pId: selectedItem!.cafeBazaarIdentity ?? '',
                token: dynamicPriceToken ?? '',
              );
              if (res.state == InAppPurchaseState.success) {
                payOrder();
                messageService.showSnackBar('پرداخت با موفقیت انجام شد');
              } else {
                messageService.showSnackBar('این پکیج قبلا خریداری شده است');
                adSubscribeState = appState;
                refresh();
              }
            } catch (e) {
              Logger.e(e);

              messageService.showSnackBar('پراخت انجام نشد');
              adSubscribeState = appState;
              refresh();
            }
          } else {
            payOrder();
          }
        } else {
          adSubscribeState = appState;
          refresh();
        }
      }),
      data: body,
    );
  }

  void payOrder() {
    PayOrderUseCase().invoke(MyFlow(flow: (appState) {
      if(appState.isFailed && appState.getErrorModel?.state == ErrorState.SuccessMsg){
        if(cafeBazaar){
          payOrderCafeBazaar();
        }
      }
      if (appState.isSuccess && appState.getData is String) {
        Logger.d('success');
        _launchUrl(appState.getData);
      }
      if (appState.isFailed) {
        Logger.d('failed');
        messageService.showSnackBar(appState.getErrorModel?.message ?? '');
        if (appState.getErrorModel?.state == ErrorState.SuccessMsg) {
          getRemainingDay();
          _notification.publish(
            'MainViewModel',
            HomeNavigationEnum.WorkShops.value,
          );
        }
      }
      adSubscribeState = appState;
      refresh();
    }), data: !cafeBazaar);
  }


  payOrderCafeBazaar(){
    PayOrderResultByCafeBazaarUseCase().invoke(
        MyFlow(flow: (resultState) {
          if (resultState.isFailed) {
            print(
                'result PayOrderResultByCafeBazaarUseCase is ${resultState.getErrorModel?.message}');
          } else {
            print(
                'result PayOrderResultByCafeBazaarUseCase is $resultState');
          }
          adSubscribeState = resultState;
          refresh();
        }), data: selectedItem?.discount ?? selectedItem?.price);
  }


  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  String getPaymentResultBuStatusCode(int? statusCode) {
    switch (statusCode) {
      case -1:
        return "اطلاعات ارسالی ناقص است.";
      case -3:
        return "ﺑﺎ ﺗﻮﺟﻪ ﺑﻪ ﻣﺤﺪﻭﺩﻳﺖ ﻫﺎﻱ ﺷﺎﭘﺮﻙ ﺍﻣﻜﺎﻥ ﭘﺮﺩﺍﺧﺖ ﺑﺎ ﺭﻗﻢ ﺩﺭﺧﻮﺍﺳﺖ ﺷﺪﻩ ممکن ﻧﻤﻲ ﺑﺎﺷﺪ.";
      case -11:
        return "ﺩﺭﺧﻮﺍﺳﺖ ﻣﻮﺭﺩ ﻧﻈﺮ ﻳﺎﻓﺖ ﻧﺸﺪ.";
      case -21:
        return "ﻫﻴﭻ ﻧﻮﻉ ﻋﻤﻠﻴﺎﺕ ﻣﺎﻟﻲ ﺑﺮﺍﻱ ﺍﻳﻦ ﺗﺮﺍﻛﻨﺶ ﻳﺎﻓﺖ ﻧﺸﺪ.";
      case -22:
        return "ﺗﺮﺍﻛﻨﺶ ﻧﺎﻣﻮﻓﻖ می باشد.";
      case -33:
        return "ﺭﻗﻢ ﺗﺮﺍﻛﻨﺶ ﺑﺎ ﺭﻗﻢ ﭘﺮﺩﺍﺧﺖ ﺷﺪﻩ ﻣﻄﺎﺑﻘﺖ ندارد.";
      case 101:
        return "عملیات پرداخت قبلاً صورت گرفته است.";
      default:
        return ErrorMessages.ErrorMessage_Connection;
    }
  }

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      checkForDeepLink();
    }
    super.didChangeAppLifecycleState(state);
  }

  void checkForDeepLink() async {
    var data = await getInitialUri();
    if (data != null) {
      var result = data.queryParameters['success']?.toString();
      if (result != null) {
        if (result == "400") {
          messageService.showSnackBar('عملیات پرداخت با خطا مواجه شد');
        } else if (result == "200") {
          getRemainingDay();
          _notification.publish(
              'MainViewModel', HomeNavigationEnum.WorkShops.value);
          messageService.showSnackBar('پرداخت با موفقیت انجام شد.');
        }
      }
    }
  }
}
