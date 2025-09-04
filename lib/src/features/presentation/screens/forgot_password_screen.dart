import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:jira_clone/src/common_widgets/custom_form_field.dart';
import 'package:jira_clone/src/constants/app_sizes.dart';
import 'package:jira_clone/src/features/presentation/providers/forgot_password_controller.dart';
import 'package:jira_clone/src/routing/app_route.dart';
import 'package:jira_clone/src/utils/async_value_ui.dart';
import 'package:jira_clone/src/utils/validators.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final emailController = TextEditingController();

  final _forgotPasswordFormKey = GlobalKey<FormState>();

  String get email => emailController.text;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      forgotPasswordControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _forgotPasswordFormKey,
          child: Column(
            children: [
              CustomFormField(
                label: 'Email',
                controller: emailController,
                validator: Validators.validateEmail,
              ),
              gapH8,
              ElevatedButton(
                onPressed: () async {
                  if (_forgotPasswordFormKey.currentState?.validate() ??
                      false) {
                    await ref
                        .read(forgotPasswordControllerProvider.notifier)
                        .verifyEmail(email);
                    if (context.mounted &&
                        !ref.read(forgotPasswordControllerProvider).hasError) {
                      context.push(AppRoute.resetPassword, extra: email);
                    }
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
