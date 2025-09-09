import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/features/profile/domain/engineer.dart';
import 'package:jira_clone/src/features/profile/presentation/providers/get_engineers_provider.dart';
import 'package:jira_clone/src/features/recycle/domain/recycle_item.dart';

class RecycleController extends Notifier<List<RecycleItem>> {
  @override
  List<RecycleItem> build() {
    final timer = Timer.periodic(Duration(seconds: 1), (timer) {
      state = [...state];
    });
    ref.onDispose(() => timer.cancel());
    return [];
  }

  void addItem(dynamic item, String name) {
    state = [...state, RecycleItem(name: name, item: item, ref: ref)];
  }

  void removeItem(RecycleItem item) {
    state = state.where((i) => i != item).toList();
  }

  void restoreItem(RecycleItem item) {
    if (item.item is Engineer) {
      final engineersProvider = ref.read(getEngineersProvider.notifier);
      removeItem(item);
      engineersProvider.restoreEngineer(item.item);
    }
  }
}

final recycleControllerProvider =
    NotifierProvider<RecycleController, List<RecycleItem>>(() {
      return RecycleController();
    });
