import 'dart:convert';
// import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyVideoPlayer extends StatefulWidget {
  const MyVideoPlayer({Key? key, this.data = ''}) : super(key: key);
  final String data;

  @override
  State<MyVideoPlayer> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  late final VideoPlayerController videoPlayerController;
  var showController = false;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    String url = '';
    if (!widget.data.startsWith('http')) {
      // final blob = html.Blob([base64Decode(widget.data)]);
      // url = html.Url.createObjectUrlFromBlob(blob);
    }

    videoPlayerController = !widget.data.startsWith('http')
        ? VideoPlayerController.network(url)
        : VideoPlayerController.network(widget.data)
      ..initialize().then(
        (_) => setState(
          () {
            if (videoPlayerController.value.isInitialized) {
              videoPlayerController.seekTo(const Duration(seconds: 3));
            }
          },
        ),
      );
    videoPlayerController.setLooping(true);
    videoPlayerController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        border: Border.all(color: Colors.grey),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: videoPlayerController.value.size.width,
              height: videoPlayerController.value.size.height,
              child: VideoPlayer(videoPlayerController),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  showController = true;
                });
                Future.delayed(const Duration(seconds: 3)).then((value) {
                  setState(() {
                    showController = false;
                  });
                });
              },
            ),
            IconButton(
                onPressed: () {
                  if (videoPlayerController.value.isPlaying) {
                    videoPlayerController.pause();
                  } else {
                    videoPlayerController.play();
                  }
                  setState(() {});
                },
                icon: AnimatedOpacity(
                  duration: const Duration(seconds: 1),
                  opacity:
                      (!videoPlayerController.value.isPlaying || showController)
                          ? 1
                          : 0,
                  child: Icon(
                    videoPlayerController.value.isPlaying
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outline,
                    size: 50.0,
                    color: Colors.grey.shade100,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
