import 'package:flutter/material.dart';
import 'package:jira_clone/src/core/service/database_service.dart';
import 'package:jira_clone/src/features/auth/data/auth_datasource.dart';
import 'package:jira_clone/src/features/presentation/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await DatabaseService().database;
  await AuthDatasource(database).login('email', 'password');
  //  await deleteDatabase(database.path);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: LoginScreen());
  }
}
