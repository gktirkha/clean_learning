// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  const AuthField({
    super.key,
    required this.hintText,
    this.controller,
    this.obscureText = false,
  });
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscuringCharacter: '*',
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$hintText is required';
        }
        return null;
      },
    );
  }
}
