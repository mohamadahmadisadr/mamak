import 'package:core/utils/imageLoader/ImageLoader.dart';
import 'package:feature/videoPlayer/MyVideoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/data/serializer/home/PackageDetailResponse.dart';
import 'package:mamak/presentation/ui/main/ConditionalUI.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/MamakScaffold.dart';
import 'package:mamak/presentation/ui/main/MamakTitle.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/viewModel/home/PackageDetailViewModel.dart';
import 'package:mamak/useCase/BaseUseCase.dart';

class PackageDetailUI extends StatelessWidget {
  const PackageDetailUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => PackageDetailViewModel(AppState.idle),
      builder: (bloc, state) {
        return ConditionalUI<PackageDetailResponse>(
          state: state,
          onSuccess: (data) {
            return MamakScaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: 32.radius,
                          bottomRight: 32.radius,
                        ),
                        color: Colors.pinkAccent.shade200,
                      ),
                      child: Column(
                        children: [
                          8.dpv,
                          MamakTitle(title: data.title ?? ''),
                          8.dpv,
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: ImageLoader(
                                url:
                                    '${BaseUrls.storagePath}/categories/${bloc.id}.png'),
                          ),
                        ],
                      ),
                    ),
                    16.dpv,
                    ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                      itemCount: data.workShops?.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            DescriptionItemUI(
                                title: data.workShops?.elementAt(index).title ??
                                    '',
                                description: data.workShops
                                        ?.elementAt(index)
                                        .description ??
                                    '',
                                image:
                                    '${BaseUrls.storagePath}/categories/${data.workShops
                                        ?.elementAt(index).id}.png'),
                            8.dpv,
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              margin: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0)),
                              child: MyVideoPlayer(
                                link:
                                    '${BaseUrls.storagePath}/Categories/${bloc.id}.mp4',
                              ),
                            ),
                            const Divider()
                          ],
                        );
                      },
                    ),
                    8.dpv,
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class DescriptionItemUI extends StatelessWidget {
  const DescriptionItemUI({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
  }) : super(key: key);
  final String title, description, image;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: context.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  description,
                  style: context.textTheme.caption,
                ),
              )
            ],
          ),
        ),
        Container(
          margin: 8.dpe,
          height: 100,
          width: 100,
          child: ImageLoader(url: image),
        ),
      ],
    );
  }
}
