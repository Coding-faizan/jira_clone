import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool obscureText;

  const CustomFormField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      controller: controller,
      validator: validator,
      obscureText: obscureText,
    );
  }
}
