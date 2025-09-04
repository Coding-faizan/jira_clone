import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/exceptions/app_exception.dart';
import 'package:jira_clone/src/features/domain/admin.dart';
import 'package:sqflite/sqflite.dart';

class AuthDatasource {
  final Database database;

  AuthDatasource(this.database);

  Future<Admin> login(String email, String password) async {
    final admin = await _getCurrentAdmin(email);
    if (admin != null) {
      if (admin.password != password) {
        throw WrongPasswordException();
      }
      debugPrint('Logged in as admin with id: ${admin.id}');
      return admin;
    } else {
      int newAdminId = await _register(email, password);
      debugPrint('Registered new admin with id: $newAdminId');
      return await _getCurrentAdmin(email) as Admin;
    }
  }

  Future<int> _register(String email, String password) async {
    final admin = Admin(email: email, password: password);
    return await database.insert('Admin', admin.toMap());
  }

  Future<Admin?> _getCurrentAdmin(String email) async {
    final List<Map<String, Object?>> maps = await database.query(
      'Admin',
      where: '${AdminFields.email} = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return Admin.fromMap(maps.first);
    }
    return null;
  }

  Future<void> verifyEmail(String email) async {
    final admin = await _getCurrentAdmin(email);
    if (admin == null) {
      throw UserNotFoundException();
    }
  }

  Future<void> updatePassword(String email, String newPassword) async {
    final admin = await _getCurrentAdmin(email);

    final updatedAdmin = admin!.copyWith(password: newPassword);
    await database.update(
      'Admin',
      updatedAdmin.toMap(),
      where: '${AdminFields.id} = ?',
      whereArgs: [admin.id],
    );
  }
}

final authDatasourceProvider = Provider<AuthDatasource>((ref) {
  throw UnimplementedError('AuthDatasource not implemented');
});
