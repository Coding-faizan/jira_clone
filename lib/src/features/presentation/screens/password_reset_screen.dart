import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jira_clone/src/common_widgets/custom_form_field.dart';
import 'package:jira_clone/src/constants/app_sizes.dart';
import 'package:jira_clone/src/features/presentation/providers/reset_password_controller.dart';
import 'package:jira_clone/src/routing/app_route.dart';
import 'package:jira_clone/src/utils/validators.dart';

class PasswordResetScreen extends ConsumerStatefulWidget {
  const PasswordResetScreen({super.key, required this.email});
  final String email;
  @override
  ConsumerState<PasswordResetScreen> createState() =>
      _PasswordResetScreenState();
}

class _PasswordResetScreenState extends ConsumerState<PasswordResetScreen> {
  final _passwordResetFormKey = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String get newPassword => newPasswordController.text;
  String get confirmPassword => confirmPasswordController.text;

  @override
  Widget build(BuildContext context) {
    final resetState = ref.watch(resetPasswordControllerProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Reset Password')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _passwordResetFormKey,
          child: Column(
            children: [
              CustomFormField(
                label: 'New Password',
                controller: newPasswordController,
                validator: Validators.validatePassword,
                obscureText: true,
              ),
              gapH4,
              CustomFormField(
                label: 'Confirm Password',
                controller: confirmPasswordController,
                validator: (value) => Validators.validateConfirmPassword(
                  newPassword,
                  confirmPassword,
                ),
                obscureText: true,
              ),
              gapH8,
              ElevatedButton(
                onPressed: resetState.isLoading
                    ? null
                    : () async {
                        if (_passwordResetFormKey.currentState?.validate() ??
                            false) {
                          await ref
                              .read(resetPasswordControllerProvider.notifier)
                              .resetPassword(widget.email, newPassword);
                          if (context.mounted) {
                            context.go(AppRoute.home);
                          }
                        }
                      },
                child: Text('Reset Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
