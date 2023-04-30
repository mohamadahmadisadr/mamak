import 'package:core/utils/imageLoader/ImageLoader.dart';
import 'package:flutter/material.dart';
import 'package:mamak/config/apiRoute/BaseUrls.dart';
import 'package:mamak/data/serializer/home/HomeResponse.dart';

class HomeSliderUi extends StatefulWidget {
  const HomeSliderUi({Key? key, required this.images}) : super(key: key);
  final List<String> images;

  @override
  State<HomeSliderUi> createState() => _HomeSliderUiState();
}

class _HomeSliderUiState extends State<HomeSliderUi> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const BouncingScrollPhysics(),
      pageSnapping: true,
      scrollDirection: Axis.horizontal,
      controller: _controller,
      children: widget.images
          .map(
            (image) => SizedBox(
              height: 270.0,
              child: ImageLoader(
                url: image,
              ),
            ),
          )
          .toList(),
    );
  }
}
