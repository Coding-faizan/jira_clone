import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/features/profile/data/engineer/engineer_repo.dart';
import 'package:jira_clone/src/features/profile/domain/engineer.dart';
import 'package:jira_clone/src/features/profile/presentation/providers/get_engineers_provider.dart';
import 'package:jira_clone/src/features/recycle/presentation/recycle_controller.dart';

class EngineerDetailController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> saveEngineerDetails(Engineer engineer, bool isNew) async {
    state = const AsyncValue.loading();
    final engineerRepository = ref.read(engineerRepoProvider);

    if (isNew) {
      state = await AsyncValue.guard(
        () => engineerRepository.createEngineerProfile(engineer),
      );
    } else {
      state = await AsyncValue.guard(
        () => engineerRepository.updateEngineerProfile(engineer),
      );
    }

    ref.invalidate(getEngineersProvider);
  }

  Future<void> deleteEngineer(Engineer engineer) async {
    // state = const AsyncValue.loading();
    // final engineerRepository = ref.read(engineerRepoProvider);
    // state = await AsyncValue.guard(
    //   () => engineerRepository.deleteEngineerProfile(engineerId),
    // );

    // ref.invalidate(getEngineersProvider);
    final recycleController = ref.read(recycleControllerProvider.notifier);
    recycleController.addItem(engineer, engineer.name);
  }
}

final engineerDetailControllerProvider = AsyncNotifierProvider(
  () => EngineerDetailController(),
);
