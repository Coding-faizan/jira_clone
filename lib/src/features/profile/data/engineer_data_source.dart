import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/features/profile/domain/engineer.dart';
import 'package:sqflite/sqflite.dart';

class EngineerDataSource {
  final Database _database;

  EngineerDataSource({required Database database}) : _database = database;

  Future<List<Engineer>> getEngineers(int adminId) async {
    final maps = await _database.query(
      'Engineer',
      where: '${EngineerFields.adminId} = ?',
      whereArgs: [adminId],
    );
    return maps.map((map) => Engineer.fromMap(map)).toList();
  }

  Future<Engineer?> getEngineerProfile(int engineerId) async {
    final maps = await _database.query(
      'Engineer',
      where: '${EngineerFields.id} = ?',
      whereArgs: [engineerId],
    );
    return maps.isNotEmpty ? Engineer.fromMap(maps.first) : null;
  }

  Future<void> createEngineerProfile(Engineer engineer) async {
    try {
      int id = await _database.insert('Engineer', engineer.toMap());
      debugPrint('Created Engineer with id: $id');
    } on Exception catch (e) {
      debugPrint('Failed to create Engineer: $e');
    }
  }

  Future<void> updateEngineerProfile(Engineer engineer) async {
    await _database.update(
      'Engineer',
      engineer.toMap(),
      where: '${EngineerFields.id} = ?',
      whereArgs: [engineer.id],
    );
    debugPrint('Updated Engineer with id: ${engineer.id}');
  }

  Future<void> deleteEngineerProfile(int engineerId) async {
    await _database.delete(
      'Engineer',
      where: '${EngineerFields.id} = ?',
      whereArgs: [engineerId],
    );
  }
}

final engineerDataSourceProvider = Provider<EngineerDataSource>(
  (ref) => throw UnimplementedError(),
);
