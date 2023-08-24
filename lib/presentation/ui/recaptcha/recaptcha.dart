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
    platformViewRegistry.registerViewFactory(
      createdViewId,
      (int viewId) => IFrameElement()
        ..style.height = '100%'
        ..style.width = '100%'
        ..src =
            'assets/html/recaptcha.html' // Path to your HTML file containing the reCAPTCHA widget.
        ..style.border = 'none',
    );
    listenResponse();
    super.initState();
  }

  Future<bool> verifyToken(String token) async {
    Uri uri = Uri.parse('https://www.google.com/recaptcha/api/siteverify');
    final response = await GetIt.I.get<KanoonHttp>().post(
      uri,
      data: {
        'secret': 'YOUR_SECRET_KEY',
        'response': token,
      },
    );
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse['success']) {
      return true;
    } else {
      return false;
    }
  }

  void listenResponse(){
    window.onMessage.listen((msg) {
      Logger.d('msg is ${msg.data}');
      verifyToken(msg.data).then((isVerified) {
        if (isVerified) {
          Logger.d('verified');
        } else {
          // Handle reCAPTCHA verification failure (optional).
          // You can show an error message or take appropriate actions.
          print('reCAPTCHA verification failed.');
        }
      });
    });
  }

}
