import 'dart:convert';

import 'package:core/utils/imageLoader/ImageLoader.dart';
import 'package:feature/navigation/NavigationService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mamak/config/apiRoute/BaseUrls.dart';
import 'package:mamak/config/appData/route/AppRoute.dart';
import 'package:mamak/data/serializer/child/GetAllUserChilPackageResponse.dart';
import 'package:mamak/data/serializer/subscribe/SubscribesResponse.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';

class PackagesGridView extends StatelessWidget {
  const PackagesGridView(
      {Key? key, required this.packages, required this.childPackage})
      : super(key: key);
  final List<SubscribeItem?> packages;
  final List<ChildPackage> childPackage;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: packages.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 130,
        mainAxisSpacing: 16.0
      ),
      itemBuilder: (context, index) => PackagesItemUI(
        package: packages[index],
        childPackage: childPackage.getChildPackage(
          packages[index]?.id?.toString(),
        ),
      ),
    );
  }
}

class PackagesItemUI extends StatelessWidget {
  const PackagesItemUI({
    Key? key,
    required this.package,
    required this.childPackage,
  }) : super(key: key);
  final SubscribeItem? package;
  final ChildPackage? childPackage;

  @override
  Widget build(BuildContext context){
    print(childPackage);
    return InkWell(
      onTap: () {
        GetIt.I.get<NavigationServiceImpl>().navigateTo(
              AppRoute.packageDetail,
              package?.id?.toString(),
            );
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            border: Border.all(color: Colors.grey)),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16.0),
                  topLeft: Radius.circular(16.0)),
              child: SizedBox(
                height: 50,
                child: ImageLoader(
                    url: '${BaseUrls.storagePath}/packages/${package?.id}.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(package?.title ?? '',
                  style: context.textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(4.0),
            //   child: Text(package?.description ?? ''),
            // ),
            if (childPackage != null)
              Row(
                children: [
                  Container(
                    margin: 2.dpe,
                    alignment: Alignment.center,
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black)),
                    child: (childPackage != null &&
                            childPackage?.childPicture != null)
                        ? ClipRRect(
                            borderRadius: 45.bRadius,
                            child: Image.memory(
                              base64Decode(
                                  childPackage!.childPicture!.content!),
                              fit: BoxFit.fill,
                            ),
                          )
                        : const Icon(
                            Icons.person,
                            size: 12,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      childPackage?.childName ?? '',
                      style: context.textTheme.bodySmall
                          ?.copyWith(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
