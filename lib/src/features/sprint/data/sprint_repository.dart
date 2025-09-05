import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/features/sprint/data/sprint_data_source.dart';
import 'package:jira_clone/src/features/sprint/domain/sprint.dart';

class SprintRepository {
  final SprintDataSource _dataSource;

  SprintRepository({required SprintDataSource dataSource})
    : _dataSource = dataSource;

  Future<List<Sprint>> getSprints(int adminId) async {
    return await _dataSource.getSprints(adminId);
  }

  Future<void> insertSprint(Sprint sprint) async {
    await _dataSource.insertSprint(sprint);
  }

  Future<void> updateSprint(Sprint sprint) async {
    await _dataSource.updateSprint(sprint);
  }

  Future<void> deleteSprint(int id) async {
    await _dataSource.deleteSprint(id);
  }
}

final sprintRepositoryProvider = Provider((ref) {
  final dataSource = ref.read(sprintDataSourceProvider);
  return SprintRepository(dataSource: dataSource);
});
