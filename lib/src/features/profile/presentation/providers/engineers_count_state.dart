import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/features/profile/presentation/providers/get_engineers_provider.dart';

final engineersCountProvider = StateProvider<int>((ref) {
  final engineers = ref.watch(getEngineersProvider).asData?.value ?? [];
  return engineers.length;
});

final limitReachedProvider = StateProvider<String>((ref) {
  final engineers = ref.watch(getEngineersProvider).asData?.value ?? [];
  final developers = engineers.where((e) => e.role == 'developer').toList();
  final testers = engineers.where((e) => e.role == 'tester').toList();

  if (developers.length == 4) {
    return 'developer';
  }
  if (testers.length == 4) {
    return 'tester';
  }
  return '';
});
