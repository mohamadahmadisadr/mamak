import 'package:feature/videoPlayer/MyVideoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:mamak/config/uiCommon/WidgetSize.dart';

class VideoPlayerDialog extends StatelessWidget {
  const VideoPlayerDialog({Key? key, required this.link}) : super(key: key);
  final String link;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      insetPadding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
      child: SizedBox(
          height: 300.0,
          width: MediaQuery.of(context).size.width,
          child: MyVideoPlayer(link: link)),
    );
  }
}
