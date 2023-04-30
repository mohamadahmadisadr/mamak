import 'package:feature/videoPlayer/MyVideoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:mamak/data/serializer/subscribe/SubscribesResponse.dart';
import 'package:mamak/presentation/ui/Home/HomeSliderUi.dart';
import 'package:mamak/presentation/ui/Home/PackagesGridView.dart';
import 'package:mamak/presentation/ui/category/CategoriesHorizontalListUi.dart';
import 'package:mamak/presentation/ui/main/ConditionalUI.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/MamakLogo.dart';
import 'package:mamak/presentation/ui/main/MamakScaffold.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/presentation/viewModel/home/HomeViewModel.dart';
import 'package:mamak/useCase/home/PackagesViewModel.dart';
import 'package:url_launcher/url_launcher.dart';


class HomeUI extends StatelessWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => HomeViewModel(AppState.idle),
      builder: (bloc, state) {
        return MamakScaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 270.0,
                  child: HomeSliderUi(
                    images: [
                      'http://62.106.95.127/StaticFiles/banner1.jpg',
                      'http://62.106.95.127/StaticFiles/banner1.jpg'
                    ],
                  ),
                ),
                4.dp,
                SizedBox(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: const CategoriesHorizontalListUi(),
                ),
                const Divider(),
                CubitProvider(
                  create: (context) => PackagesViewModel(AppState.idle),
                  builder: (bloc, state) {
                    return ConditionalUI<List<SubscribeItem>>(
                      skeleton: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        margin: 8.dpe,
                        padding: 8.dpe,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: 8.bRadius,
                        ),
                      ),
                      state: bloc.packagesState,
                      onSuccess: (packages) =>
                          PackagesGridView(packages: packages,childPackage: bloc.childPackages),
                    );
                  },
                ),
                8.dpv,
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: const MyVideoPlayer(
                      link: 'http://62.106.95.127/StaticFiles/MamakInfo.mp4'),
                ),
                4.dpv,
                InkWell(
                onTap: () {
                    _launchUrl('http://62.106.95.127/StaticFiles/RoadMap.pdf');
                },
                  child: Container(
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
  }
}

Future<void> _launchUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}