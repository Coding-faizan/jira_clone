import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/features/sprint/presentation/active_sprints_tab.dart';
import 'package:jira_clone/src/features/sprint/presentation/providers/get_sprints.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sprintsAsyncValue = ref.watch(getSprintsProvider);
    return sprintsAsyncValue.when(
      data: (sprints) {
        return DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(text: 'Active'),
                  Tab(text: 'Completed'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ActiveSprintsTab(),
                    Center(child: Text('Content for Completed Tab')),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return Center(child: Text('Error: $error'));
      },
      loading: () {
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
