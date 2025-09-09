import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/features/recycle/presentation/recycle_controller.dart';

class RecycleScreen extends ConsumerWidget {
  const RecycleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recycleItems = ref.watch(recycleControllerProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Recycle Bin')),
      body: recycleItems.isEmpty
          ? Center(child: Text('No items in recycle bin'))
          : ListView.builder(
              itemCount: recycleItems.length,
              itemBuilder: (context, index) {
                final item = recycleItems[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(
                    'Item will be deleted permanently in ${30 - item.duration} seconds',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          ref
                              .read(recycleControllerProvider.notifier)
                              .removeItem(item);
                        },
                        icon: Icon(Icons.delete),
                      ),
                      IconButton(
                        icon: Icon(Icons.restore),
                        onPressed: () {
                          ref
                              .read(recycleControllerProvider.notifier)
                              .restoreItem(item);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
