import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/core/service/database_service.dart';
import 'package:jira_clone/src/features/sprint/domain/sprint.dart';
import 'package:sqflite/sqflite.dart';

class SprintDataSource {
  final Database _database;

  SprintDataSource({required Database database}) : _database = database;

  Future<List<Sprint>> getSprints(int adminId) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      SprintFields.tableName,
      where: '${SprintFields.adminId} = ?',
      whereArgs: [adminId],
    );
    return maps.map((map) => Sprint.fromMap(map)).toList();
  }

  Future<void> insertSprint(Sprint sprint) async {
    await _database.insert(SprintFields.tableName, sprint.toMap());
  }

  Future<void> updateSprint(Sprint sprint) async {
    await _database.update(
      SprintFields.tableName,
      sprint.toMap(),
      where: '${SprintFields.id} = ?',
      whereArgs: [sprint.id],
    );
  }

  Future<void> deleteSprint(int id) async {
    await _database.delete(
      SprintFields.tableName,
      where: '${SprintFields.id} = ?',
      whereArgs: [id],
    );
  }
}

final sprintDataSourceProvider = Provider((ref) {
  final database = ref.read(dataBaseProvider);
  return SprintDataSource(database: database);
});
