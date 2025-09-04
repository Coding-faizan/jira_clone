import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/features/auth/presentation/providers/auth_state_controller.dart';
import 'package:jira_clone/src/features/profile/data/engineer_repo.dart';
import 'package:jira_clone/src/features/profile/domain/engineer.dart';

final getEngineersProvider = FutureProvider<List<Engineer>>((ref) async {
  final engineerRepo = ref.read(engineerRepoProvider);
  final adminId = ref.watch(authStateControllerProvider).asData!.value!;
  return await engineerRepo.getEngineers(adminId);
});
