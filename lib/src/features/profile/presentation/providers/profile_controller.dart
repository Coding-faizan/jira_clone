import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/features/auth/presentation/providers/auth_state_controller.dart';
import 'package:jira_clone/src/features/profile/data/profile/profile_repository.dart';

class ProfileController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    // Initialize the controller
  }

  Future<void> deleteProfile() async {
    state = const AsyncValue.loading();
    final adminId = ref.read(authStateControllerProvider).asData!.value!;
    state = await AsyncValue.guard(
      () => ref.read(profileRepositoryProvider).deleteProfile(adminId),
    );
  }

  Future<void> logout() async {
    ref.invalidate(authStateControllerProvider);
  }
}

final profileControllerProvider =
    AsyncNotifierProvider<ProfileController, void>(() => ProfileController());
