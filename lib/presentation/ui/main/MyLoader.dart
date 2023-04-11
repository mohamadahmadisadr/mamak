import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyLoader extends StatelessWidget {
  const MyLoader({Key? key, this.color = Colors.black}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(
      color: color,
    );
  }
}
