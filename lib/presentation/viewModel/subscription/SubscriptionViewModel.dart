import 'package:core/Notification/MyNotification.dart';
import 'package:core/network/errorHandler/common/ErrorMessages.dart';
import 'package:flutter/material.dart';
import 'package:mamak/data/body/subscribe/AddSubscribeBody.dart';
import 'package:mamak/data/body/subscribe/DiscountCodeBody.dart';
import 'package:mamak/data/serializer/subscribe/AllSubscriptionResponse.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/HomeNavigationModel.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/payment/PayOrderUseCase.dart';
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
  final TextEditingController codeController = TextEditingController();
  final MyNotification _notification = GetIt.I.get();

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

  void refresh() {
    updateScreen(time: DateTime.now().microsecondsSinceEpoch.toDouble());
  }

  onChangeSelectedItem(AllSubscriptionItem? newSelected) {
    if (newSelected != null) {
      selectedItem = newSelected;
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

      DiscountCodeUseCase().invoke(MyFlow(flow: (appState) {
        if (appState.isSuccess) {
          selectedItem?.discount = int.tryParse(appState.getData) ?? 0;
        }
        if (appState.isFailed) {
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

  void submitSubscribe() {
    if (selectedItem == null) {
      messageService.showSnackBar('اشتراک موردنظر را انتخاب کنید');
      return;
    }
    AddSubscribeBody body = AddSubscribeBody(
      subscriptionId: selectedItem?.id?.toString() ?? '',
      discountCode: codeController.text,
    );
    AddSubscribeUseCase().invoke(
      MyFlow(flow: (appState) {
        if (appState.isFailed) {
          messageService.showSnackBar(appState.getErrorModel?.message ?? '');
        }
        if (appState.isSuccess) {
          payOrder();
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
      if (appState.isSuccess && appState.getData is String) {
        _launchUrl(appState.getData);
      }
      if (appState.isFailed) {
        messageService.showSnackBar(appState.getErrorModel?.message ?? '');
      }
      adSubscribeState = appState;
      refresh();
    }));
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication)) {
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
