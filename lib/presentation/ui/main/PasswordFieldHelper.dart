
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/core/form/validator/PasswordValidator.dart';

class PasswordFieldHelper extends StatefulWidget {
  const PasswordFieldHelper(
      {Key? key, required this.onChangeValue, this.isRePsw = false})
      : super(key: key);
  final Function(String) onChangeValue;
  final bool isRePsw;

  @override
  State<PasswordFieldHelper> createState() => _PasswordFieldHelperState();
}

class _PasswordFieldHelperState extends State<PasswordFieldHelper> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        label: Text('password'.tr),
        hintText: 'password'.tr,
        prefixIcon: const Icon(CupertinoIcons.lock_fill),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          icon: Icon(
            obscureText ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
          ),
        ),
      ),
      obscureText: obscureText,
      onChanged: widget.onChangeValue,
      validator: (value) => PasswordValidator(widget.isRePsw).validate(value ?? '').msg,
    );
  }
}
