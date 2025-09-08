import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jira_clone/src/common_widgets/custom_form_field.dart';
import 'package:jira_clone/src/constants/app_sizes.dart';
import 'package:jira_clone/src/features/auth/presentation/providers/auth_state_controller.dart';
import 'package:jira_clone/src/features/profile/domain/engineer.dart';
import 'package:jira_clone/src/features/profile/presentation/providers/engineer_detail_controller.dart';
import 'package:jira_clone/src/features/profile/presentation/providers/engineers_count_state.dart';
import 'package:jira_clone/src/utils/async_value_ui.dart';
import 'package:jira_clone/src/utils/validators.dart';

class EngineerDetailDialog extends ConsumerStatefulWidget {
  const EngineerDetailDialog({super.key, this.engineer});
  final Engineer? engineer;

  @override
  ConsumerState<EngineerDetailDialog> createState() =>
      _EngineerDetailDialogState();
}

class _EngineerDetailDialogState extends ConsumerState<EngineerDetailDialog> {
  final TextEditingController _nameController = TextEditingController();

  String engineerRole = '';

  String get engineerName => _nameController.text;

  bool get isNewEngineer => widget.engineer == null;

  final _engineerDetailFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.engineer?.name ?? '';
    engineerRole = widget.engineer?.role ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final engineerDetailState = ref.watch(engineerDetailControllerProvider);
    ref.listen(
      engineerDetailControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    return AlertDialog(
      title: Text('Engineer Details'),
      content: Form(
        key: _engineerDetailFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomFormField(
              controller: _nameController,
              label: 'Name',
              validator: Validators.validateName,
            ),
            gapH8,
            if (ref.watch(developersProvider).length < 4)
              //todo: make them reusable
              ListTile(
                horizontalTitleGap: 0,
                title: const Text('Developer'),
                leading: Radio(
                  value: 'developer',
                  groupValue: engineerRole,
                  onChanged: (value) {
                    setState(() {
                      engineerRole = value!;
                    });
                  },
                ),
              ),
            if (ref.watch(testersProvider).length < 4)
              ListTile(
                horizontalTitleGap: 0,
                title: const Text('Tester'),
                leading: Radio(
                  value: 'tester',
                  groupValue: engineerRole,
                  onChanged: (value) {
                    setState(() {
                      engineerRole = value!;
                    });
                  },
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            //todo: refactor
            Engineer? newEngineer = widget.engineer;
            if (isNewEngineer) {
              final adminId = ref
                  .read(authStateControllerProvider)
                  .asData!
                  .value!;

              newEngineer = Engineer(
                name: engineerName,
                role: engineerRole,
                adminId: adminId,
              );
            } else {
              newEngineer = newEngineer!.copyWith(
                name: engineerName,
                role: engineerRole,
              );
            }
            if (_engineerDetailFormKey.currentState!.validate() &&
                engineerRole.isNotEmpty) {
              await ref
                  .read(engineerDetailControllerProvider.notifier)
                  .saveEngineerDetails(newEngineer, isNewEngineer);
              if (context.mounted) context.pop();
            }
          },
          child: engineerDetailState.isLoading
              ? const CircularProgressIndicator()
              : Text(isNewEngineer ? 'Create' : 'Update'),
        ),
      ],
    );
  }
}
