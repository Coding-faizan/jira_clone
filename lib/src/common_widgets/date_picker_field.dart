import 'package:flutter/material.dart';
import 'package:jira_clone/src/extensions.dart';

class DatePickerField extends StatelessWidget {
  const DatePickerField({
    super.key,
    required this.controller,
    required this.label,
    this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateSelected,
  });

  final TextEditingController controller;
  final String label;
  final DateTime? initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime> onDateSelected;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        icon: Icon(Icons.calendar_today),
        labelText: label,
      ),
      onTap: () =>
          showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: firstDate,
            lastDate: lastDate,
          ).then((value) {
            if (value != null) {
              controller.text = value.toFormattedString();
              onDateSelected(value);
            }
          }),
    );
  }
}
