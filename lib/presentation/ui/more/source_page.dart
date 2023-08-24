import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/presentation/ui/main/MamakScaffold.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:url_launcher/url_launcher.dart';

class SourceUi extends StatelessWidget {
  const SourceUi({super.key});

  @override
  Widget build(BuildContext context) {
    return MamakScaffold(body: Padding(
      padding: 16.dpe,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
                'تمام محتواها به صورت انحصاری توسط انتشارات مهر کودکانه پرستو تولید گردیده است و حق مادی و معنوی آن برای مجموعه محفوظ است.',
                style: context.textTheme.bodySmall),
            16.dpv,
            TextButton(onPressed: () {
              _launchUrl(
                  Uri.parse('https://mamakschool.ir/home/privacy'));
            }, child: Text('policy'.tr))
          ],
        ),
      ),
    ));
  }

  Future<void> _launchUrl(Uri uri) async {
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }
}
