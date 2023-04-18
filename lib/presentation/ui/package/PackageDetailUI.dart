import 'package:core/utils/imageLoader/ImageLoader.dart';
import 'package:feature/videoPlayer/MyVideoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/presentation/ui/main/SubscribeButton.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';

class PackageDetailUI extends StatelessWidget {
  const PackageDetailUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: 16.radius, bottomRight: 16.radius),
              child: const ImageLoader(
                  url:
                      'https://www.mamakschool.ir/images/Banner/638107826390104202slide%203.jpg'),
            ),
          ),
          8.dpv,
          const DescriptionItemUI(),
          8.dpv,
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            margin: const EdgeInsets.all(4.0),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
            child: const MyVideoPlayer(),
          ),
          const Divider(),
          const DescriptionItemUI(),
          8.dpv,
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            margin: const EdgeInsets.all(4.0),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
            child: const MyVideoPlayer(),
          ),
          const Divider(),
          const DescriptionItemUI(),
          16.dpv,
          const SubscribeButton(),
          16.dpv,
        ],
      ),
    );
  }
}

class DescriptionItemUI extends StatelessWidget {
  const DescriptionItemUI({
    Key? key,
  }) : super(key: key);

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
                  'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ',
                  style: context.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.',
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
          child: const ImageLoader(
              url:
                  'https://www.mamakschool.ir/images/Banner/638107826390104202slide%203.jpg'),
        ),
      ],
    );
  }
}
