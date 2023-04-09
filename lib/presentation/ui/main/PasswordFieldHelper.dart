import 'package:feature/form/validator/login/PasswordValidator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordFieldHelper extends StatefulWidget {
  const PasswordFieldHelper({Key? key, required this.onChangeValue})
      : super(key: key);
  final Function(String) onChangeValue;

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
        label: const Text('رمز عبور'),
        hintText: 'رمز عبور',
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
      validator: (value) => PasswordValidator().validate(value ?? '').msg,
    );
  }
}
