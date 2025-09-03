import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/common_widgets/custom_form_field.dart';
import 'package:jira_clone/src/constants/app_sizes.dart';
import 'package:jira_clone/src/features/presentation/auth_state_controller.dart';
import 'package:jira_clone/src/utils/validators.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login / Choose User')),
      body: LoginForm(),
    );
  }
}

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

  String get email => emailController.text;
  String get password => passwordController.text;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authController = ref.read(authStateControllerProvider.notifier);
    final authState = ref.watch(authStateControllerProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        key: _loginFormKey,
        autovalidateMode: AutovalidateMode.onUnfocus,
        child: Column(
          children: [
            CustomFormField(
              label: 'Email',
              controller: emailController,
              validator: Validators.validateEmail,
            ),
            gapH8,
            CustomFormField(
              label: 'Password',
              controller: passwordController,
              validator: Validators.validatePassword,
            ),
            gapH8,
            ElevatedButton(
              onPressed: authState.isLoading
                  ? null
                  : () {
                      if (_loginFormKey.currentState?.validate() ?? false) {
                        authController.login(email, password);
                      }
                    },
              child: authState.isLoading
                  ? CircularProgressIndicator()
                  : Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
