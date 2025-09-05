import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/features/profile/domain/engineer.dart';

class ConfirmationDialog extends ConsumerWidget {
  const ConfirmationDialog({
    super.key,
    required this.engineer,
    required this.onConfirmation,
  });

  final Engineer engineer;
  final VoidCallback onConfirmation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Delete Engineer'),
      content: const Text('Are you sure you want to delete this engineer?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(onPressed: onConfirmation, child: const Text('Delete')),
      ],
    );
  }
}
