import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mamak/config/uiCommon/WidgetSize.dart';
import 'package:mamak/core/locale/locale_extension.dart';
import 'package:mamak/data/serializer/subscribe/AllSubscriptionResponse.dart';
import 'package:mamak/data/serializer/subscribe/CurrentPackageResponse.dart';
import 'package:mamak/presentation/ui/main/ConditionalUI.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/MamakScaffold.dart';
import 'package:mamak/presentation/ui/main/MyLoader.dart';
import 'package:mamak/presentation/ui/main/TextFormFieldHelper.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/ui/register/RegisterUi.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/presentation/viewModel/subscription/SubscriptionViewModel.dart';
import  'package:persian_number_utility/persian_number_utility.dart';
import 'package:shamsi_date/shamsi_date.dart';
import '../main/MamakTitle.dart';

class SubscriptionUI extends StatelessWidget {
  const SubscriptionUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MamakScaffold(
      body: Padding(
        padding: 8.dpe,
        child: CubitProvider(
          create: (context) => SubscriptionViewModel(AppState.idle),
          builder: (bloc, state) {
            return ConditionalUI<List<AllSubscriptionItem>>(
              state: bloc.uiState,
              onSuccess: (data) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          width: 10,
                          height: 10,
                          margin: 2.dpeh,
                        ),
                        MamakTitle(
                          title: 'subscribe'.tr,
                        )
                      ],
                    ),
                    const Divider(),
                    ConditionalUI<CurrentPackageResponse>(
                      state: bloc.mySubscriptionState,
                      onSuccess: (currentSubscription) {
                        // var date = DateFormat('YYYY/bM/bD').parse(currentSubscription
                        //     .persianEndDate ?? '');
                        // var dateStr = Get.locale.isPersian ? (currentSubscription.persianEndDate ?? '') : Jalali(date.year,date.month,date.day).toDateTime().toIso8601String();
                        var de = '${currentSubscription.title ?? ''} ${'is'
                            .tr} ${'to'.tr} ${currentSubscription
                            .persianEndDate ?? ''} ${'active'.tr}.';
                        return Container(
                          alignment: Alignment.center,
                          padding: 16.dpe,
                          margin: 8.dpe,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: 8.bRadius),
                          child: Text(
                              Get.locale.isPersian
                                  ? '${currentSubscription.title ?? ''} ${'to'
                                  .tr} ${currentSubscription.persianEndDate ??
                                  ''} ${'is_active'.tr}.'
                                  : de),
                        );
                      },
                    ),
                    16.dpv,
                    // Row(
                    //   children: [
                    //     Container(
                    //       decoration: const BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         color: Colors.blue,
                    //       ),
                    //       width: 10,
                    //       height: 10,
                    //       margin: 2.dpeh,
                    //     ),
                    //     const Text('برای تغییر اشتراک کلیک کنید'),
                    //   ],
                    // ),
                    4.dpv,
                    FormTitleWithStar(
                      title: 'subscribe'.tr,
                    ),
                    8.dpv,
                    DropDownPackageFields(
                      selectedItem: bloc.selectedItem,
                      items: data,
                      name: 'choose_plan_type'.tr,
                      onValueChange: bloc.onChangeSelectedItem,
                    ),
                    8.dpv,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormFieldHelper(
                              label: 'discount_code'.tr,
                              hint: 'discount_code'.tr,
                              keyboardType: TextInputType.text,
                              onChangeValue: bloc.onChangeCode),
                        ),
                        8.dp,
                        ElevatedButton(
                            onPressed: bloc.submitCode,
                            child: bloc.discountCodeState.isLoading
                                ? const MyLoader()
                                : Text('save'.tr)),
                      ],
                    ),
                    8.dpv,
                    if (bloc.selectedItem != null)
                      Row(
                        children: [
                          Text(
                            'price_to_pay'.tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                          8.dph,
                          Expanded(
                            flex: 1,
                            child: Text(
                              bloc.selectedItem?.discount == null
                                  ? "${bloc.selectedItem?.price ?? 0} ${'rial'
                                  .tr}"
                                  : "${bloc.selectedItem?.discount ??
                                  0} '${'rial'.tr}'",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: WidgetSize.normalTitle,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          )
                        ],
                      ),
                    16.dpv,
                    Padding(
                      padding: 8.dpe,
                      child: ElevatedButton(
                          onPressed: bloc.submitSubscribe,
                          child: bloc.adSubscribeState.isLoading
                              ? const MyLoader()
                              : Text('next_step'.tr)),
                    )
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class DropDownPackageFields extends StatelessWidget {
  const DropDownPackageFields({Key? key,
    required this.selectedItem,
    required this.items,
    required this.name,
    required this.onValueChange})
      : super(key: key);
  final AllSubscriptionItem? selectedItem;
  final List<AllSubscriptionItem> items;
  final String name;
  final Function(AllSubscriptionItem?) onValueChange;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButtonFormField<AllSubscriptionItem>(
        value: selectedItem,
        menuMaxHeight: 200,
        isDense: false,
        isExpanded: false,
        borderRadius: const BorderRadius.all(
            Radius.circular(WidgetSize.textFieldRadiusSize)),
        hint: Text(
          name,
          style: context.textTheme.bodySmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textScaleFactor: .9,
        ),
        onChanged: onValueChange,
        items: List.generate(items.length, (index) {
          var item = items.elementAt(index);
          return DropdownMenuItem<AllSubscriptionItem>(
            value: item,
            child: Text(
              '${item.title} ${item.price?.toString()}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textScaleFactor: .9,
            ),
          );
        }),
      ),
    );
  }
}
