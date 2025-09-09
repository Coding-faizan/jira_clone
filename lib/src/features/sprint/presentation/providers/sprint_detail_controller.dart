import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/features/sprint/data/sprint_repository.dart';
import 'package:jira_clone/src/features/sprint/domain/sprint.dart';
import 'package:jira_clone/src/features/sprint/presentation/providers/get_sprints.dart';

class SprintDetailController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> saveSprintDetails(Sprint sprint, bool isNewSprint) async {
    state = AsyncValue.loading();
    final sprintRepo = ref.read(sprintRepositoryProvider);
    state = await AsyncValue.guard(() async {
      if (isNewSprint) {
        sprintRepo.createSprint(sprint);
      } else {
        sprintRepo.updateSprint(sprint);
      }
    });

    ref.invalidate(getSprintsProvider);
  }

  Future<void> deleteSprint(int sprintId) async {
    state = AsyncValue.loading();
    final sprintRepo = ref.read(sprintRepositoryProvider);
    state = await AsyncValue.guard(() async {
      sprintRepo.deleteSprint(sprintId);
    });

    ref.invalidate(getSprintsProvider);
  }

  Future<void> toggleSprintCompletion(Sprint sprint) async {
    state = AsyncValue.loading();
    final sprintRepo = ref.read(sprintRepositoryProvider);
    state = await AsyncValue.guard(() async {
      sprintRepo.updateSprint(sprint.copyWith(isActive: !sprint.isActive));
    });

    ref.invalidate(getSprintsProvider);
  }
}

final sprintDetailControllerProvider = AsyncNotifierProvider(
  () => SprintDetailController(),
);
