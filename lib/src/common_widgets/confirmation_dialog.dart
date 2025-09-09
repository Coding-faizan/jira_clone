import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ConfirmationDialog extends ConsumerWidget {
  const ConfirmationDialog({
    super.key,
    required this.onConfirmation,
    required this.title,
    required this.content,
  });

  final VoidCallback onConfirmation;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(onPressed: onConfirmation, child: const Text('Delete')),
      ],
    );
  }
}
