import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final String? initialValue;
  final int? maxLength;

  const CustomFormField({
    super.key,

    required this.label,
    required this.controller,
    this.initialValue,
    this.validator,
    this.obscureText = false,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(labelText: label),
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      maxLength: maxLength,
    );
  }
}
