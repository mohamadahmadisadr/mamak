import 'package:core/utils/imageLoader/ImageLoader.dart';
import 'package:flutter/material.dart';

import 'InnerRowWidget.dart';

class MamakLogo extends StatelessWidget {
  const MamakLogo({Key? key, this.width = 150.0}) : super(key: key);
  final double width;

  @override
  Widget build(BuildContext context) {
    return InnerRowWidget(
      alignment: MainAxisAlignment.center,
      child: SizedBox(
      width: width,
        child: const ImageLoader(
          fitModel: BoxFit.fill,
          url: 'https://www.mamakschool.ir/images/headerlogo.png',
        ),
      ),
    );
  }
}
