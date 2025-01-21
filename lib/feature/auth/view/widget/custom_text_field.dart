// ignore_for_file: must_be_immutable

import 'package:api_project/feature/auth/view/widget/border_text_field.dart';
import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.prefix,
    this.controller,
    this.validator,
    this.suffix,
    this.keyboard,
    this.obscureText = false,
  });
  final TextEditingController? controller;
  final String label;
  final String hint;
  final IconData prefix;
  final IconButton? suffix;
  final bool obscureText;
  String? Function(String?)? validator;
  TextInputType? keyboard;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      controller: controller,
      keyboardType: keyboard,
      obscureText: obscureText,
      decoration: InputDecoration(
          label: Text(label),
          hintText: hint,
          prefixIcon: Icon(prefix),
          suffixIcon: suffix,
          border: border(radius: 10, color: Colors.purpleAccent),
          focusedBorder: border(color: Colors.purpleAccent, radius: 15),
          prefixIconColor: Colors.purpleAccent,
          suffixIconColor: Colors.purpleAccent),
    );
  }
}