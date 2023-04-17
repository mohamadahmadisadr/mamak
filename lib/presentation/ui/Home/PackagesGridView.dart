import 'package:core/utils/imageLoader/ImageLoader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/config/apiRoute/BaseUrls.dart';
import 'package:mamak/data/serializer/home/HomeResponse.dart';

class PackagesGridView extends StatelessWidget {
  const PackagesGridView({Key? key, required this.packages}) : super(key: key);
  final List<PackageWorkshops> packages;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: packages.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisExtent: 120),
        itemBuilder: (context, index) =>
            PackagesItemUI(package: packages[index]));
  }
}

class PackagesItemUI extends StatelessWidget {
  const PackagesItemUI({Key? key, required this.package}) : super(key: key);
  final PackageWorkshops package;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: 120,
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
                  url: BaseUrls.storagePath +
                      (package.iconUrl?.replaceAll("\\", "/") ?? '')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(package.packageTitle ?? '',
                style: context.textTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(package.teacherName ?? ''),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
