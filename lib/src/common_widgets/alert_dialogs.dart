import 'package:flutter/material.dart';

Future<bool?> showAlertDialog({
  required BuildContext context,
  required String title,
  String? content,
  String? cancelActionText,
  String defaultActionText = 'OK',
}) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content ?? ''),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('OK'),
        ),
      ],
    ),
  );
}

/// Generic function to show a platform-aware Material or Cupertino error dialog
Future<void> showExceptionAlertDialog({
  required BuildContext context,
  required String title,
  required dynamic exception,
}) => showAlertDialog(
  context: context,
  title: title,
  content: exception.toString(),
  defaultActionText: 'OK',
);

Future<void> showNotImplementedAlertDialog({required BuildContext context}) =>
    showAlertDialog(context: context, title: 'Not implemented');
