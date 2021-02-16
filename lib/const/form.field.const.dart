import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  final bool obscureText;
  final Widget suffixIcon;
  const CustomFormField({
    Key key,
    this.hintText,
    this.icon,
    this.obscureText = false,
    this.suffixIcon,
    this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      placeholder: hintText,
      obscureText: obscureText,
      keyboardType: TextInputType.visiblePassword,
      enableSuggestions: false,
      controller: controller,
    );
  }
}
