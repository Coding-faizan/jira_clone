import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/features/auth/presentation/providers/auth_state_controller.dart';
import 'package:jira_clone/src/features/sprint/data/sprint_repository.dart';
import 'package:jira_clone/src/features/sprint/domain/sprint.dart';

final getSprintsProvider = FutureProvider<List<Sprint>>((ref) async {
  final sprintService = ref.watch(sprintRepositoryProvider);
  final adminId = ref.watch(authStateControllerProvider).asData?.value ?? 1;
  return sprintService.getSprints(adminId);
});

final activeSprintsProvider = Provider<List<Sprint>>((ref) {
  final sprints = ref.watch(getSprintsProvider).asData?.value ?? [];
  final activeSprints = sprints
      .where((sprint) => sprint.status == 'active')
      .toList();
  return activeSprints;
});

final completedSprintsProvider = Provider<List<Sprint>>((ref) {
  final sprints = ref.watch(getSprintsProvider).asData?.value ?? [];
  final completedSprints = sprints
      .where((sprint) => sprint.status == 'completed')
      .toList();
  return completedSprints;
});
