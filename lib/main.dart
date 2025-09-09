import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jira_clone/src/core/service/database_service.dart';
import 'package:jira_clone/src/routing/app_route.dart';
import 'package:jira_clone/src/routing/app_router.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await DatabaseService().database;
  //await deleteDatabase(database.path);

  runApp(
    ProviderScope(
      overrides: [dataBaseProvider.overrideWithValue(database)],
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
