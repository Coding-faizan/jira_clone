import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/features/profile/domain/engineer.dart';
import 'package:jira_clone/src/features/sprint/domain/sprint.dart';
import 'package:jira_clone/src/features/ticket/domain/ticket.dart';
import 'package:jira_clone/src/features/auth/domain/admin.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final getDirectory = await getApplicationDocumentsDirectory();
    String path = '${getDirectory.path}/jira.db';
    debugPrint('Database path: $path');
    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Admin(
        ${AdminFields.id} INTEGER PRIMARY KEY,
        ${AdminFields.email} TEXT UNIQUE,
        ${AdminFields.password} TEXT
      )''');

    await db.execute('''
      CREATE TABLE Engineer(
        ${EngineerFields.id} INTEGER PRIMARY KEY,
        ${EngineerFields.name} TEXT,
        ${EngineerFields.role} TEXT,
        ${EngineerFields.adminId} INTEGER,
        FOREIGN KEY (${EngineerFields.adminId}) REFERENCES Admin(${EngineerFields.adminId}) ON DELETE CASCADE
      )''');
    await db.execute('''
      CREATE TABLE Sprint (
        ${SprintFields.id} INTEGER PRIMARY KEY,
        ${SprintFields.title} TEXT,
        ${SprintFields.isActive} INTEGER,
        ${SprintFields.startDate} TEXT,
        ${SprintFields.endDate} TEXT,
        ${SprintFields.adminId} INTEGER,
        FOREIGN KEY (${SprintFields.adminId}) REFERENCES Admin(${SprintFields.adminId}) ON DELETE CASCADE
      )''');
    await db.execute('''
      CREATE TABLE Ticket (
        ${TicketFields.id} INTEGER PRIMARY KEY,
        ${TicketFields.title} TEXT,
        ${TicketFields.description} TEXT,
        ${TicketFields.sprintId} INTEGER,
        ${TicketFields.developer} TEXT,
        ${TicketFields.tester} TEXT,
        ${TicketFields.status} TEXT,
        FOREIGN KEY (${TicketFields.sprintId}) REFERENCES Sprint(${TicketFields.sprintId}) ON DELETE CASCADE
      )
      ''');

    debugPrint('Database tables created');
  }
}

final dataBaseProvider = Provider<Database>((ref) {
  throw UnimplementedError();
});
