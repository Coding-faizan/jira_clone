import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/features/auth/data/auth_repository.dart';
import 'package:jira_clone/src/features/auth/presentation/providers/auth_state_controller.dart';

class ResetPasswordController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> resetPassword(String email, String newPassword) async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncValue.loading();
    await AsyncValue.guard(
      () => authRepository.updatePassword(email, newPassword),
    );

    // Notify the auth state controller to log in with the new password
    await ref
        .read(authStateControllerProvider.notifier)
        .login(email, newPassword);
  }
}

final resetPasswordControllerProvider = AsyncNotifierProvider(
  () => ResetPasswordController(),
);
