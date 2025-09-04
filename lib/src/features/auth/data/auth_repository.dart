import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/features/auth/data/auth_datasource.dart';

class AuthRepository {
  final AuthDatasource _authDatasource;
  AuthRepository({required AuthDatasource authDatasource})
    : _authDatasource = authDatasource;

  Future<int> login(String email, String password) async {
    return await _authDatasource.login(email, password);
  }

  Future<void> verifyEmail(String email) async {
    await _authDatasource.verifyEmail(email);
  }

  Future<void> updatePassword(String email, String newPassword) async {
    await _authDatasource.updatePassword(email, newPassword);
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authDatasource = ref.read(authDatasourceProvider);
  return AuthRepository(authDatasource: authDatasource);
});
