import 'package:core/utils/imageLoader/ImageLoader.dart';
import 'package:flutter/material.dart';

import 'InnerRowWidget.dart';

class MamakLogo extends StatelessWidget {
  const MamakLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const InnerRowWidget(
      alignment: MainAxisAlignment.center,
      child: SizedBox(
      width: 150.0,
        child: ImageLoader(
          fitModel: BoxFit.fill,
          url: 'https://www.mamakschool.ir/images/headerlogo.png',
        ),
      ),
    );
  }
}
