import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/core/service/database_service.dart';
import 'package:jira_clone/src/features/sprint/domain/sprint.dart';
import 'package:sqflite/sqflite.dart';

class SprintDataSource {
  final Database _database;

  SprintDataSource({required Database database}) : _database = database;

  Future<List<Sprint>> getSprints(int adminId) async {
    try {
      final List<Map<String, dynamic>> maps = await _database.query(
        SprintFields.tableName,
        where: '${SprintFields.adminId} = ?',
        whereArgs: [adminId],
      );
      print('Fetched sprints: $maps');
      return maps.map((map) => Sprint.fromMap(map)).toList();
    } catch (e) {
      print('Error fetching sprints: $e');
      return [];
    }
  }

  Future<void> insertSprint(Sprint sprint) async {
    try {
      final mappedSprint = sprint.toMap();
      await _database.insert(SprintFields.tableName, mappedSprint);
    } catch (e) {
      print('Error inserting sprint: $e');
    }
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
