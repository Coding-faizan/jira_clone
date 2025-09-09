import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jira_clone/src/common_widgets/custom_form_field.dart';
import 'package:jira_clone/src/common_widgets/date_picker_field.dart';
import 'package:jira_clone/src/constants/app_sizes.dart';
import 'package:jira_clone/src/extensions.dart';
import 'package:jira_clone/src/features/auth/presentation/providers/auth_state_controller.dart';
import 'package:jira_clone/src/features/sprint/domain/sprint.dart';
import 'package:jira_clone/src/features/sprint/presentation/providers/sprint_detail_controller.dart';
import 'package:jira_clone/src/utils/validators.dart';

class SprintDetailDialog extends ConsumerStatefulWidget {
  const SprintDetailDialog({super.key, this.sprint});
  final Sprint? sprint;

  @override
  ConsumerState<SprintDetailDialog> createState() => _SprintDetailDialogState();
}

class _SprintDetailDialogState extends ConsumerState<SprintDetailDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  bool get isNewSprint => widget.sprint == null;
  String get title => _nameController.text;

  final _sprintDetailFormKey = GlobalKey<FormState>();

  // These are for values to store
  late DateTime startDate = DateTime.now();
  late DateTime endDate;

  @override
  void initState() {
    super.initState();
    if (!isNewSprint) {
      _nameController.text = widget.sprint!.title;
      startDate = widget.sprint!.startDate;
      endDate = widget.sprint!.endDate;
      _startDateController.text = widget.sprint!.startDate.toFormattedString();
      _endDateController.text = widget.sprint!.endDate.toFormattedString();
    }
  }

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
            DatePickerField(
              initialDate: isNewSprint ? null : startDate,
              controller: _startDateController,
              onDateSelected: (value) {
                startDate = value;
              },
              label: 'Start Date',
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 30)),
            ),
            gapH16,
            DatePickerField(
              initialDate: isNewSprint ? null : endDate,
              controller: _endDateController,
              onDateSelected: (value) {
                endDate = value;
              },
              label: 'End Date',
              firstDate: startDate.add(Duration(days: 1)),
              lastDate: DateTime.now().add(Duration(days: 30)),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => context.pop(), child: const Text('Cancel')),
        TextButton(
          onPressed: () async {
            if (_sprintDetailFormKey.currentState!.validate()) {
              Sprint sprint;
              if (isNewSprint) {
                sprint = Sprint(
                  title: title,
                  isActive: true,
                  startDate: startDate,
                  endDate: endDate,
                  adminId: ref.read(authStateControllerProvider).asData!.value!,
                );
              } else {
                sprint = widget.sprint!.copyWith(
                  title: title,
                  startDate: startDate,
                  endDate: endDate,
                );
              }
              final sprintDetailController = ref.read(
                sprintDetailControllerProvider.notifier,
              );
              await sprintDetailController.saveSprintDetails(
                sprint,
                isNewSprint,
              );
              if (context.mounted) context.pop();
            }
          },
          child: ref.watch(sprintDetailControllerProvider).isLoading
              ? CircularProgressIndicator()
              : Text(isNewSprint ? 'Create' : 'Update'),
        ),
      ],
    );
  }
}
