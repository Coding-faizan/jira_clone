import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/features/auth/data/auth_datasource.dart';
import 'package:jira_clone/src/features/domain/admin.dart';

class AuthRepository {
  final AuthDatasource _authDatasource;
  AuthRepository({required AuthDatasource authDatasource})
    : _authDatasource = authDatasource;

  Future<Admin> login(String email, String password) async {
    return await _authDatasource.login(email, password);
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authDatasource = ref.read(authDatasourceProvider);
  return AuthRepository(authDatasource: authDatasource);
});
