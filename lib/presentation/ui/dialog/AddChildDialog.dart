import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/config/uiCommon/WidgetSize.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';

class AddChildDialog extends StatelessWidget {
  const AddChildDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        insetPadding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
        child: Padding(
          padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('add_child'.tr,
                  style: context.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              4.dpv,
              Text(
                'no_child_msg'.tr,
                style: context.textTheme.titleMedium,
              ),
              20.dpv,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      GetIt.I
                          .get<NavigationServiceImpl>()
                          .replaceTo(AppRoute.addChild);
                    },
                    child: Text('yes'.tr),
                  ),
                  8.dph,
                  ElevatedButton(
                    onPressed: () {
                      GetIt.I.get<NavigationServiceImpl>().pop();
                    },
                    child: Text('no'.tr),
                  )
                ],
              ),
              8.dpv,
            ],
          ),
        ),
      ),
    );
  }
}
