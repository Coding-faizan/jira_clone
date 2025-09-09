import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/features/recycle/presentation/recycle_controller.dart';

class RecycleItem<T> {
  final String name;
  final T item;
  int duration;
  final Ref ref;

  RecycleItem({required this.name, required this.item, required this.ref})
    : duration = 0 {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (duration == 30) {
        ref.read(recycleControllerProvider.notifier).removeItem(this);
        timer.cancel();
      }
      duration += 1;
    });
  }
}
