import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jira_clone/src/common_widgets/custom_form_field.dart';
import 'package:jira_clone/src/constants/app_sizes.dart';
import 'package:jira_clone/src/features/sprint/domain/sprint.dart';
import 'package:jira_clone/src/utils/validators.dart';

class SprintDetailDialog extends ConsumerStatefulWidget {
  const SprintDetailDialog({super.key, this.sprint});
  final Sprint? sprint;

  @override
  ConsumerState<SprintDetailDialog> createState() => _SprintDetailDialogState();
}

class _SprintDetailDialogState extends ConsumerState<SprintDetailDialog> {
  final TextEditingController _nameController = TextEditingController();

  bool get isNewSprint => widget.sprint == null;

  final _sprintDetailFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Sprint Details'),
      content: Form(
        key: _sprintDetailFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomFormField(
              controller: _nameController,
              label: 'Title',
              validator: Validators.validateName,
            ),
            gapH16,
            InputDatePickerFormField(
              fieldLabelText: 'Start date',
              firstDate: DateTime.now(),
              lastDate: DateTime(2025, 12, 31),
            ),
            gapH16,
            InputDatePickerFormField(
              fieldLabelText: 'End date',
              firstDate: DateTime.now(),
              lastDate: DateTime(2025, 12, 31),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => context.pop(), child: const Text('Cancel')),
        TextButton(
          onPressed: () {
            if (_sprintDetailFormKey.currentState!.validate()) {}
          },
          child: Text(isNewSprint ? 'Create' : 'Update'),
        ),
      ],
    );
  }
}
