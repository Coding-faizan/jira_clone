import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/features/auth/data/auth_repository.dart';

class ForgotPasswordController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> verifyEmail(String email) async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => authRepository.verifyEmail(email));
  }
}

final forgotPasswordControllerProvider = AsyncNotifierProvider(
  () => ForgotPasswordController(),
);
