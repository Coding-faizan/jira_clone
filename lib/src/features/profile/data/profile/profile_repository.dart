import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/features/profile/data/profile/profile_data_source.dart';

class ProfileRepository {
  final ProfileDataSource _dataSource;

  ProfileRepository(this._dataSource);

  Future<void> deleteProfile(int id) async {
    await _dataSource.deleteProfile(id);
  }
}

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final dataSource = ref.read(profileDataSourceProvider);
  return ProfileRepository(dataSource);
});
