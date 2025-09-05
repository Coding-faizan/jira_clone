import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/features/profile/presentation/providers/get_engineers_provider.dart';

final developers = Provider((ref) {
  final engineers = ref.watch(getEngineersProvider).asData?.value ?? [];
  return engineers.where((e) => e.role == 'developer').toList();
});

final testers = Provider((ref) {
  final engineers = ref.watch(getEngineersProvider).asData?.value ?? [];
  return engineers.where((e) => e.role == 'tester').toList();
});
