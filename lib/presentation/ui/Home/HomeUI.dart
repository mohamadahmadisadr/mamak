import 'package:feature/videoPlayer/MyVideoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:mamak/data/serializer/home/HomeResponse.dart';
import 'package:mamak/presentation/ui/Home/CategoriesListView.dart';
import 'package:mamak/presentation/ui/Home/HomeSliderUi.dart';
import 'package:mamak/presentation/ui/main/ConditionalUI.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/MamakLogo.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/presentation/viewModel/home/HomeViewModel.dart';

import 'HomeAppbar.dart';
import 'PackagesGridView.dart';

class HomeUI extends StatelessWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => HomeViewModel(AppState.idle),
      builder: (bloc, state) {
        return ConditionalUI<HomeResponse>(
          state: state,
          onSuccess: (data) {
            return Scaffold(
              appBar: AppBar(flexibleSpace: const HomeAppBar()),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 270.0,
                      child: HomeSliderUi(images: data.mainImage ?? []),
                    ),
                    4.dp,
                    SizedBox(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: CategoriesListView(
                          items: data.carrouselImages ?? [],
                        )),
                    const Divider(),
                    PackagesGridView(packages: data.packageWorkshops ?? []),
                    8.dpv,
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      margin: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: MyVideoPlayer(link: data.videoFile?.link ?? ''),
                    ),
                    4.dpv,
                    Container(
                      margin: 8.dpe,
                      height: 70,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'برنامه راهبردی',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.indigo,
                              ),
                            ),
                            8.dph,
                            const MamakLogo(),
                          ],
                        ),
                      ),
                    ),
                    4.dpv,
                    Padding(
                      padding: 8.0.dpeh,
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text('خریداشتراک')),
                    ),
                    8.dpv
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
