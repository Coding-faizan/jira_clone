import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/core/service/database_service.dart';
import 'package:jira_clone/src/features/auth/domain/admin.dart';
import 'package:sqflite/sqlite_api.dart';

class ProfileDataSource {
  final Database _database;

  ProfileDataSource({required Database database}) : _database = database;

  Future<void> deleteProfile(int id) async {
    await _database.delete(
      'Admin',
      where: '${AdminFields.id} = ?',
      whereArgs: [id],
    );
    debugPrint('Admin Deleted');
  }
}

final profileDataSourceProvider = Provider<ProfileDataSource>((ref) {
  final database = ref.read(dataBaseProvider);
  return ProfileDataSource(database: database);
});
