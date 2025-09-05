import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/features/profile/data/engineer/engineer_data_source.dart';
import 'package:jira_clone/src/features/profile/domain/engineer.dart';

class EngineerRepo {
  final EngineerDataSource _dataSource;

  EngineerRepo({required EngineerDataSource dataSource})
    : _dataSource = dataSource;

  Future<List<Engineer>> getEngineers(int adminId) async {
    return await _dataSource.getEngineers(adminId);
  }

  Future<Engineer?> getEngineerProfile(int engineerId) async {
    return await _dataSource.getEngineerProfile(engineerId);
  }

  Future<void> createEngineerProfile(Engineer engineer) async {
    await _dataSource.createEngineerProfile(engineer);
  }

  Future<void> updateEngineerProfile(Engineer engineer) async {
    await _dataSource.updateEngineerProfile(engineer);
  }

  Future<void> deleteEngineerProfile(int engineerId) async {
    await _dataSource.deleteEngineerProfile(engineerId);
  }
}

final engineerRepoProvider = Provider<EngineerRepo>((ref) {
  final engineerDataSource = ref.read(engineerDataSourceProvider);
  return EngineerRepo(dataSource: engineerDataSource);
});
