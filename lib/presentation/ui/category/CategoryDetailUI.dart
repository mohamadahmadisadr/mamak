import 'package:core/utils/imageLoader/ImageLoader.dart';
import 'package:feature/videoPlayer/MyVideoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:mamak/data/serializer/home/CategoryDetailResponse.dart';
import 'package:mamak/presentation/ui/main/ConditionalUI.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/MamakScaffold.dart';
import 'package:mamak/presentation/ui/main/MamakTitle.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/viewModel/home/CategoryDetailViewModel.dart';
import 'package:mamak/useCase/BaseUseCase.dart';

class CategoryDetailUI extends StatelessWidget {
  const CategoryDetailUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => CategoryDetailViewModel(AppState.idle),
      builder: (bloc, state) {
        return ConditionalUI<CategoryDetailResponse>(
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
                                url: '${BaseUrls.storagePath}/categories/${bloc.id}.png'),
                          ),
                        ],
                      ),
                    ),
                    16.dpv,
                    Padding(
                      padding: 16.dpe,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            data.title ?? '',
                            textAlign: TextAlign.start,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          4.dpv,
                          SizedBox(
                            height: 60,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.subCategories?.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  alignment: Alignment.center,
                                  padding: 8.dpeh,
                                  margin: 8.dpe,
                                  decoration: BoxDecoration(
                                    borderRadius: 8.bRadius,
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Text(data.subCategories
                                          ?.elementAt(index)
                                          .title ??
                                      ''),
                                );
                              },
                            ),
                          ),
                          16.dpv,
                          SizedBox(
                          height: 280,
                            child: MyVideoPlayer(
                                link: '${BaseUrls.storagePath}/Categories/${bloc.id}.mp4'),
                          ),
                          16.dpv,
                          Column(
                            children: List.generate(4, (index) {
                              var url = '${BaseUrls.storagePath}/CategoryDetails/${bloc.id}/${index + 1}.jpg';
                              return Column(
                                children: [
                                  ImageLoader(
                                      url: url),
                                  10.dpv,
                                ],
                              );
                            }).toList(),
                          )
                        ],
                      ),
                    ),
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
