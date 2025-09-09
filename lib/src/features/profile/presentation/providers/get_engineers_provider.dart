import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/features/auth/presentation/providers/auth_state_controller.dart';
import 'package:jira_clone/src/features/profile/data/engineer/engineer_repo.dart';
import 'package:jira_clone/src/features/profile/domain/engineer.dart';
import 'package:jira_clone/src/features/recycle/presentation/recycle_controller.dart';

// final getEngineersProvider = FutureProvider<List<Engineer>>((ref) async {
//   final engineerRepo = ref.read(engineerRepoProvider);
//   final adminId = ref.watch(authStateControllerProvider).asData!.value!;
//   return await engineerRepo.getEngineers(adminId);
// });

class GetEngineersNotifier extends AsyncNotifier<List<Engineer>> {
  @override
  Future<List<Engineer>> build() async {
    final engineerRepo = ref.read(engineerRepoProvider);
    final adminId = ref.watch(authStateControllerProvider).asData!.value!;
    return await engineerRepo.getEngineers(adminId);
  }

  void removeEngineer(Engineer engineer) {
    final recycleController = ref.read(recycleControllerProvider.notifier);
    final newState = state.value!.where((e) => e != engineer).toList();
    state = AsyncValue.data(newState);
    recycleController.addItem(engineer, engineer.name);
  }

  void restoreEngineer(Engineer engineer) {
    final newState = [...state.value!, engineer];
    state = AsyncValue.data(newState);
  }
}

final getEngineersProvider = AsyncNotifierProvider(
  () => GetEngineersNotifier(),
);
