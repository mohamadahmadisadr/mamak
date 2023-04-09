import 'package:core/utils/imageLoader/ImageLoader.dart';
import 'package:feature/videoPlayer/MyVideoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';

class HomeUI extends StatelessWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 300.0,
              child: ImageLoader(
                  url:
                      'https://www.mamakschool.ir/images/Banner/638107826390104202slide%203.jpg'),
            ),
            4.dp,
            SizedBox(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    width: 70,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                            width: 60,
                            height: 60,
                            child: ImageLoader(
                                url:
                                    'https://www.mamakschool.ir/images/Banner/638107826390104202slide%203.jpg')),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text('سواد',
                              style: context.textTheme.caption?.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisExtent: 120),
              itemBuilder: (context, index) => const PackagesItemUI(),
            ),
            8.dpv,
            Container(
            width: MediaQuery.of(context).size.width,
              height: 200,
              margin: const EdgeInsets.all(4.0),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
              child: const MyVideoPlayer(),
            ),
            4.dpv,
            Container(
            margin: 8.dpe,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            4.dpv,
            Padding(
              padding: 8.0.dpeh,
              child: ElevatedButton(onPressed: (){}, child: const Text('خریداشتراک')),
            ),
            8.dpv
          ],
        ),
      ),
    );
  }
}

class PackagesItemUI extends StatelessWidget {
  const PackagesItemUI({Key? key}) : super(key: key);

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
          const ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16.0),
                topLeft: Radius.circular(16.0)),
            child: SizedBox(
                height: 40,
                child: ImageLoader(
                    url:
                        'https://www.mamakschool.ir/images/Banner/638107826390104202slide%203.jpg')),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text('data',
                style: context.textTheme.caption
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ),
          const Padding(
            padding: EdgeInsets.all(4.0),
            child: Text('data'),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
