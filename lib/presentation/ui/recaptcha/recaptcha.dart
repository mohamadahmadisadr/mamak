import 'dart:convert';
import 'dart:html';
import 'dart:ui_web';

import 'package:core/dioNetwork/kanoonHttp/KanoonHttp.dart';
import 'package:core/utils/logger/Logger.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Recaptcha extends StatefulWidget {
  const Recaptcha({super.key});

  @override
  State<Recaptcha> createState() => _RecaptchaState();
}

class _RecaptchaState extends State<Recaptcha> {
  String createdViewId = 'map_element';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: HtmlElementView(
        viewType: createdViewId,
      ),
    );
  }

  @override
  void initState() {
    Logger.d('initializing');
    platformViewRegistry.registerViewFactory(
      createdViewId,
      (int viewId) => IFrameElement()
        ..style.height = '100%'
        ..style.width = '100%'
        ..src =
            'assets/html/recaptcha.html' // Path to your HTML file containing the reCAPTCHA widget.
        ..style.border = 'none',
    );
    Logger.d('initialized');
    listenResponse();
    super.initState();
  }


  void listenResponse(){
    Logger.d('listenning');
    window.onMessage.listen((msg) {
      Logger.d('msg is ${msg.data}');

    });
  }

}
