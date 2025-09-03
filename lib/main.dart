import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/core/service/database_service.dart';
import 'package:jira_clone/src/features/auth/data/auth_datasource.dart';
import 'package:jira_clone/src/features/presentation/login_screen.dart';
import 'package:jira_clone/src/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await DatabaseService().database;
  await AuthDatasource(database).login('email', 'password');
  // await deleteDatabase(database.path);
  runApp(
    ProviderScope(
      overrides: [
        authDatasourceProvider.overrideWithValue(AuthDatasource(database)),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.read(goRouterProvider);

    return MaterialApp.router(routerConfig: goRouter);
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text('Welcome to the Home Screen!')),
    );
  }
}
