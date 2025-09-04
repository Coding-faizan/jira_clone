import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/features/auth/data/auth_repository.dart';

class AuthStateController extends AsyncNotifier<int?> {
  @override
  Future<int?> build() async {
    return null;
  }

  Future<void> login(String email, String password) async {
    final authRepository = ref.read(authRepositoryProvider);

    state = AsyncValue.loading();
    state = await AsyncValue.guard(() => authRepository.login(email, password));
  }

  void logout() {
    state = AsyncValue.data(null);
  }
}

final authStateControllerProvider = AsyncNotifierProvider(() {
  return AuthStateController();
});
