import 'package:core/videoPlayer/MyVideoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:mamak/data/serializer/home/intro/intro_content_response.dart';
import 'package:mamak/presentation/state/app_state.dart';
import 'package:mamak/presentation/ui/main/ConditionalUI.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/viewModel/app/home_intro_vm.dart';

class HomeIntroUi extends StatelessWidget {
  const HomeIntroUi({super.key});

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => HomeIntroViewModel(AppState.idle),
      builder: (bloc, state) {
        return ConditionalUI<IntroContentResponse>(
          skeleton: Expanded(child: Container(color: Colors.grey.shade200)),
          state: state,
          onSuccess: (video) {
            return MyVideoPlayer(
              data: video.video?.content ?? '',
            );
          },
        );
      },
    );
  }
}
